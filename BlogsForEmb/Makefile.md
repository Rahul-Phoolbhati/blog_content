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
thing_wrong := *.o # Don't do this! '*' will not get expanded thing_right := $(wildcard *.o)
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


@06-03-2025 

