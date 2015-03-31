####Setup build environment
Open terminal and use the following command more [information](https://developer.mozilla.org/en-US/docs/Mozilla/Developer_guide/Build_Instructions/Linux_Prerequisites)

```
wget -O bootstrap.py https://hg.mozilla.org/mozilla-central/raw-file/default/python/mozboot/bin/bootstrap.py && python bootstrap.py
```

#### [Manual Build Instructions](https://8pecxstudios.com/Forums/viewtopic.php?f=5&t=685&p=6067#manual-build-instructions):

Note: Using git is much easier then downloading a large archive that sometimes fails or is damaged, It downloads very fast through git.

So what you do is:

In the terminal __if you don't have__ git installed

```sudo apt-get install git```

Next cd to your working directory

Now `clone` the release repository

```git clone https://github.com/InternalError503/cyberfox.git```

Once it has finished downloaded you need to *set the folder permissions*, The reason for this is its inheriting git servers file permissions, In the terminal type

```chmod -R 777 cyberfox```

Then press enter.

Now the permissions have be set to you.

Now setup your `mozconfig` and any addition changes like setting the branding identity color

Once ready `cd` inside the `cyberfox folder` and in the terminal type

```./mach build```

Once compilation is complete just checkout your build and in the terminal type

```./mach run```

Just to test everything runs ok

When ready to finalize the build in the terminal type

```./mach package```

This will package up the build (Note: we don't have any installer like systems for cyberfox on linux but we are looking into it).

The next time you want to *build cyberfox* just `cd` into the source folder then type

```git pull```

This should pull all the new files.

If the repo says you have uncommitted or untracked changes just do

```
git checkout -- .
git pull
```

If the above does not clear any uncommitted or un-tracked changes

```
git checkout -- .
git pull origin master --force
```

You will have to set the mozconfig again if not already present as it should ignore this file and keep any changes you make to it.

If the local git repository wont let you pull the latest due to uncommitted changes or un-tracked files and the above __"git checkout -- ."__ does not resolve the merge conflict
then in terminal type:

```git reset --hard```

This should revert all changes to modified files.

Note: Once you have pulled the latest tree from the git repo you will have to set the permissions again so you need to set the folder permissions,
The reason for this is its inheriting git servers file permissions, if your inside the cyberfox folder in the terminal type:

```cd ..```

This will take you up one directory then in the terminal type

```chmod -R 777 cyberfox```

Then press enter, Now the permissions have be set to you, Now just `cd` back in to `cyberfox directory`

```cd cyberfox```


Once you have done this a few times it gets very quick and easy.
Git is a very easy source code management system with very few commands which is why its so easy to use and very powerful in source control.
For additional information please see this [article](https://8pecxstudios.com/Forums/viewtopic.php?f=5&t=685#p4351)

*Important:* Keep in mind that on Linux everything is case sensitive so if the folder is named cyberfox and your typing Cyberfox you will get an error.

###### Notes: in the cyberfox version 37.0

To set the browser branding identity color for build type specific you need to edit the following file

`cyberfox\build\defines.sh`

its a simple system 1 equals enabled (true) and blank disabled (false) for branding identity only one can be enabled.

So on linux it would look like the following

```
# Set the browser branding identity color
IDENTITY_BRANDING_AMD=
IDENTITY_BRANDING_BETA=
IDENTITY_BRANDING_LINUX=1
IDENTITY_BRANDING_INTEL=
```

#### [Quick Build Instructions](https://8pecxstudios.com/Forums/viewtopic.php?f=5&t=685&p=6067#quick-build-instructions):

Here is a quick build script for cyberfox on Linux that will expand over time, This will allow you to automate most of the manual tasks mentioned above.

Script version: *1.1*

```
# Cyberfox quick build script
# Version: 1.1
# Release channel

#!/bin/bash

# Set working directory default is ~/Documents
WORKDIR=~/Documents

command -v git >/dev/null 2>&1 || {
    echo "I require git but it's not installed would you like to install it now!."
    select yn in "Yes" "No"; do
   case $yn in
       Yes )
         xterm -e sudo apt-get install git
       break;;
       No ) echo "I require git but it's not installed type 'sudo apt-get install git' to manually install it then run me again!." && exit;;
   esac
    done   
 }

cd $WORKDIR

if [ -d "cyberfox" ]; then
  echo "Auto purge uncommited untracked changes"
  cd cyberfox
  git checkout -- .
  echo "Cloning latest cyberfox source files"
  git pull
  echo "Setting branding identity to linux"
  sed -i "s/\(IDENTITY_BRANDING_INTEL *= *\).*/\1/" $WORKDIR/cyberfox/build/defines.sh
  sed -i "s/\(IDENTITY_BRANDING_LINUX *= *\).*/\11/" $WORKDIR/cyberfox/build/defines.sh
  cd ..
  #Need to redo chmod and set permsissions every pull.
  echo "Changing chmod of cyberfox repository to 777"
  chmod -R 777 cyberfox
  cd cyberfox
else
  echo "Downloading cyberfox source repository"
  git clone https://github.com/InternalError503/cyberfox.git
  echo "Changing chmod of cyberfox repository to 777"
  chmod -R 777 cyberfox
  echo "mozconfig does not exist copying pre-configured to cyberfox root"
  cp -r $WORKDIR/cyberfox/_Build/_Linux/mozconfig $WORKDIR/cyberfox/
  echo "Setting branding identity to linux"
  sed -i "s/\(IDENTITY_BRANDING_INTEL *= *\).*/\1/" $WORKDIR/cyberfox/build/defines.sh
  sed -i "s/\(IDENTITY_BRANDING_LINUX *= *\).*/\11/" $WORKDIR/cyberfox/build/defines.sh
  cd cyberfox
fi

echo "Do you wish to build cyberfox now?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) ./mach build; break;;
        No ) break;;
    esac
done

echo "Do you wish to package cyberfox now?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) ./mach package; break;;
        No ) break;;
    esac
done
```

What it does is the following

First sets the working directory to "__~/Documents__" by default so if you use a different directory then change it.

To change it

```
WORKDIR=~/Documents
```

simply replace "__~/Documents__" so an example of this is

```
WORKDIR=~/Downloads
```


It then checks if git is install if not it will it will prompt you to install it, You can install it by selecting the option when prompt or not install it and then manually install it
then run the script again.

If git is installed then it checks if the cyberfox repository exist in the __$WORKDIR__ if it does then it will auto purge all changes

Then download the latest build files

It will automatically set the branding identity to Linux so not need to edit that file manually

It will then change the permissions to *777*

Then prompt to build cyberfox

If cyberfox repository does not exist then it will clone the repository in the __$WORKDIR__

It will then change the permissions to *777*

It will automatically set the branding identity to Linux so not need to edit that file manually

Then prompt to build cyberfox

Once cyberfox has been built it will prompt if you would like to package it.

The prompts are numeric so for an example

```
1) Yes
2) No
```

You would type ether __1__ for yes or __2__ for no.

Here is the __build_cyberfox.sh__

When you download this file you can run it form anywhere however you will need to chmod the permissions of the file or it will not allow you to run it.

so you would cd in to the directory its contained in then type

```chmod -R 777 build_cyberfox.sh```

Then your all set.

To use the script just open the terminal then supply the path to it for example

```~/Desktop/build_cyberfox.sh```

Note: Don't edit build_cyberfox.sh on windows as windows adds \r or \r\n to line endings to assimilate carriage returns this will just cause error messages in the script or cause it not to work.
