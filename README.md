# Bash

Here I'll be adding whatever bash scripts I write as I learn/hack the language. Here are the first two I've come up with:

## Makegen

A simple makefile generator. Give it a compilation instruction (default gcc) and a list of files, and it will add them to a makefile.

```
> ./makegen.sh main.c
adding file 'main.c'
no instructions specified, defaulting to 'gcc'
adding files:
adding make target main.c to makefile...
warning: main.c does not exist, are you sure you're in the right folder?
Finished generating makefile at /Users/thinkpad20/workspace/bash/Makefile:

all: main.c
   c main.c
```

When I expand it, it will create an `all` instruction with all arguments specified, as well as individual make instructions. Maybe more later.

## Defc

Creates a C source file with standard boilerplate. `stdio.h` and `stdlib.h` are included by default. You can pass in whatever other include files you want. A `-g` tag means the include should be a global include (using <>).

```
> ./defc.sh foobar.c foobar.h -g string.h
C file created at foobar.c:
#include <stdio.h>
#include <stdlib.h>
#include "foobar.h"
#include <string.h>

int main(int argc, char *argv[]) {
   return 0;
}
```

The program will not overwrite an existing file unless `-f` is passed in.