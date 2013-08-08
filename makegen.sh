#!/bin/bash


# makegen will generate a makefile for one of a few compiles:
# initially just c and haskell.
state="initial"
compile="none"
output="$(pwd)/Makefile"
declare -a files=()
for var in "$@" 
do
   if [[ $state == "initial" && ($var == "--compile" || $var == "-c") ]] ; then
      state="readcompile"
   elif [[ $state == "readcompile" ]] ; then
      compile=$var
      state="initial"
   elif [[ $state == "initial" && $var == "-o" ]] ; then
      state="readoutput"
   elif [[ $state == "readoutput" ]] ; then
      output=$var
      echo "Outputting to $output"
      state="initial"
   elif [[ $state == "initial" ]] ; then
      files+=( $var )
      echo "adding file '$var'"
   fi
done

if [[ $compile == "none" ]] ; then
   echo "no instructions specified, defaulting to 'gcc'"
   compile="c"
fi
echo "adding files:"
for file in ${files[@]}
do
   echo "adding make target $file to makefile..."
   printf "\nall: $file\n\t$compile $file\n" >> $output

   if [[ ! (-e $file) ]] ; then
      echo "warning: $file does not exist, are you sure you're in the right folder?"
   fi
done

echo "Finished generating makefile at $output:"
cat $output