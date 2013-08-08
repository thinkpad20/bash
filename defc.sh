#!/bin/bash
if [[ -z $1 ]] ; then
   echo "Error, please specify a filename"
   exit
fi

file=$1
shift
state="readargs"
overwrite="false"
declare -a headers=("#include <stdio.h> #include <stdlib.h>")
for arg in "$@"
do
   if [[ $state == "readargs" && $arg == "-g" ]] ; then
      state="globalheader"
   elif [[ $state == "globalheader" ]] ; then
      headers+=("#include <$arg>")
      state="readargs"
   elif [[ $state == "readargs" && $arg == "-f" ]] ; then
      overwrite="true"
   else
      headers+=("#include \"$arg\"")
   fi
done

if [[ -e $file ]] ; then
   if [[ $overwrite == "false" ]] ; then
      echo "Error, $1 exists. Use argument -f to overwrite."
      exit
   else
      echo "Overwriting existing $file"
      rm $file
   fi
fi

for arg in ${headers[@]}
do
   printf "$arg" >> $file
   if [[ $arg == "#include" ]] ; then
      printf " " >> $file
   else
      printf "\n" >> $file
   fi
done

printf "\nint main(int argc, char *argv[]) {\n" >> $file
printf "   return 0;\n}\n" >> $file

echo "C file created at $file:"
cat $file