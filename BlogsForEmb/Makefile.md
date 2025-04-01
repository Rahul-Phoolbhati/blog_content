Files to make your automation of the project easy with defined targets , commands and rules.
> compilation  and building
> packaging and deploying
> tests and scripts automation
> Docker work and versioning 


Q. build tools vs makefile ?
ans. - similar but not made for the specific tasks or framework.

### syntax 
targets : prerequisites
	commands
* targets are the labels or tags to a process
* prerequisites are the task should be done before the current one

## essence of dependencies
```
	compile:
		cc blah.c -o blah
```
evry make will run the process again . but we dont want until we have changed the c file , so use as dependency. But but but .... 

#### Putting the target name as compiled file name --
```
blah.o: blah.c
echo "compiling the file"
cc blah.c -o blah.o
```
* This checks if the target exists , if not always runs the process again on make. Thats why diff names in compiled and the target wont be able to check if it needs to be redone.
* compares with the dependencies to check the changes = *filesystem timestamps as a proxy*
* The created file should not be in dependency of self (always runs otherwise)
* There are no circular dependencies (target = dependency )

	#### Problem with this ?
	let's have the dependency flow as blah->blah.o->blah.c
		If a file name of target is just modified the timestamp 
				``` touch blah.o ```
	due to the timestamp change , this will be considered new and the command with this dependency will only run , not the command with this target name (as the dependencies of that are not newer than the target file.)
---
```
blah: blah.o 
	cc blah.o -o blah # Runs third 
blah.o: blah.c 
	cc -c blah.c -o blah.o # Runs second 
blah.c: 
	echo "int main() { return 0; }" > blah.c # Runs first
```
---
> If the dependency of one and target of other is not a file created , it will run them always .
* clean with no dependencies mostly
## Variables
* Variables can only be strings
* := or = 
* quotes ar ejust char , no meaning
* Reference variables with $() or ${} , direct $x works but bad practice

## Targets
* All target for running many together
* Multiple Targets for one process  --- $@ contains all targets for the process
## Automatic Variables and Wildcards
'\*' ->
		always wrap it in the `wildcard` function
		`*` may be used in the target, prerequisites, or in the `wildcard` function.
		Danger: `*` may not be directly used in a variable definitions
		Danger: When `*` matches no files, it is left as it is (unless run in the `wildcard` function)
```
thing_wrong := *.o # Don't do this! '*' will not get expanded 
thing_right := $(wildcard *.o)
```
'\%'

___

---
automatice variables - 
```
hey: one two 
	# Outputs "hey", since this is the target name 
	echo $@
	# Outputs all prerequisites newer than the target 
	echo $? 
	# Outputs all prerequisites 
	echo $^ 
	# Outputs the first prerequisite 
	echo $< 
	touch hey 
one: 
	touch one 
two: 
	touch two
```


### Fancy Rules

#### Implicit Rules - 
- Compiling a C program: `n.o` is made automatically from `n.c` with a command of the form `$(CC) -c $(CPPFLAGS) $(CFLAGS) $^ -o $@`
- Compiling a C++ program: `n.o` is made automatically from `n.cc` or `n.cpp` with a command of the form `$(CXX) -c $(CPPFLAGS) $(CXXFLAGS) $^ -o $@`
- Linking a single object file: `n` is made automatically from `n.o` by running the command `$(CC) $(LDFLAGS) $^ $(LOADLIBES) $(LDLIBS) -o $@`

The important variables used by implicit rules are:

- `CC`: Program for compiling C programs; default `cc`
- `CXX`: Program for compiling C++ programs; default `g++`
- `CFLAGS`: Extra flags to give to the C compiler
- `CXXFLAGS`: Extra flags to give to the C++ compiler
- `CPPFLAGS`: Extra flags to give to the C preprocessor
- `LDFLAGS`: Extra flags to give to compilers when they are supposed to invoke the linker
```
CC = gcc # Flag for implicit rules 
CFLAGS = -g # Flag for implicit rules. Turn on debug info 
# Implicit rule #1: blah is built via the C linker implicit rule 
# Implicit rule #2: blah.o is built via the C compilation implicit rule, because blah.c exists 
blah: blah.o 

blah.c: 
	echo "int main() { return 0; }" > blah.c 
clean: 
	rm -f blah*
```


#### Static Pattern Rule - 
```
# Syntax - 
	targets ...: target-pattern: prereq-patterns ... 
	# In the case of the first target, foo.o, the target-pattern matches foo.o and sets the "stem" to be "foo". # It then replaces the '%' in prereq-patterns with that stem .
	$(objects): %.o: %.c 
		$(CC) -c $^ -o $@
```
#### Pattern Rule - 
```
%.o : %.c 
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@
```

#### Double-Colon Rules - 
```
all: blah 

blah:: 
	echo "hello" 
blah:: 
	echo "hello again"
```

### Commands - 

#### Silence - 
* Using $@$ before the command or `make -s` command.
#### Command are Executed in subshells - 
```
all: 
	cd .. 
	# The cd above does not affect this line, because each command is effectively run in a new shell 
	echo `pwd` 
	# This cd command affects the next because they are on the same line 
	cd ..;echo `pwd` 
	# Same as above 
	cd ..; \ 
	echo `pwd`
```

>Shell Var SHELL=/bin/bash 
>The shell change will only impact the later targets then the declaration , previous one will be in the same shell as default /bin/sh
>Shell Variables by `$$` not by `$` as the make variable .
>	sh_var='I am a shell variable'; echo `$$sh_var`

#### Error handling with `-k`, `-i`, and `-`

- Add `-k` when running make to continue running even in the face of errors. Helpful if you want to see all the errors of Make at once.  
- Add a `-` before a command to suppress the error  
- Add `-i` to make to have this happen for every command.

#### Exporting the vars - 

* with :-    $.EXPORT_ALL_VARIABLES: $ - this will export all variables 
* also with export variable_name
* Exported variables can be used in recursive call 
* can be used as shell variables 

> [!NOTE]
> When Make starts, it automatically creates Make variables out of all the environment variables that are set when it's executed.

### Functions - 
- Call functions with `$(fn, arguments)` or `${fn, arguments}`
1. Substitute -
```
	comma := , 
	empty:= 
	space := $(empty) $(empty) 
	foo := a b c 
	bar := $(subst $(space),$(comma),$(foo)) 
	
	all: 
		@echo $(bar)  # output a,b,c
```
> Do NOT include spaces in the arguments after the first. That will be seen as part of the string.
```
> bar := $(subst $(space), $(comma) , $(foo)) # Watch out!
> # Output is ", a , b , c". Notice the spaces introduced
```

