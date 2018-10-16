## To run shell script

```
qsub cluster-script.sh
```

## To check job memory (after job finishes running)

```
qacct -j <JOBID>
```

## To submit multi-core jobs

Add the following to your `.sh` script:

```
#$ -pe local K
```

Where `K` is the number of cores per job. Note that if you have

```
#$ -l mem_free=nG
#$ -l h_vmem=nG
#$ -R y
```

Then the total amount of memory per job will be n*K

## If outputting large files

Add the following to your shell script

```
#$ -l h_fsize=NG
```

Where `N` is slightly larger than the largest file you will be outputting. Default is currently `10G` (I believe)

## JHPCE information
* https://jhpce.jhu.edu/
* Bithelp: bithelp@lists.johnshopkins.edu and bithelp channel on JHU Biostat Slack
* Bitsupport: bitsupport@lists.johnshopkins.edu

First contact bitsupport to be added to bithelp listserve. Bithelp is for most problems (errors while installing/running software for the most part), bitsupport for issues such as requests for temporary increase in memory limits


## How to install UNISON on cluster

### Option 1: Install OCAML then install Unison through github

```
mkdir -p ~/Downloads
cd ~/Downloads
### Replace below with appropriate version
wget http://caml.inria.fr/pub/distrib/ocaml-4.07/ocaml-4.07.1.tar.gz
tar -xvzf ocaml-4.07.1.tar.gz
cd ocaml-4.07.1
mkdir -p ~/src
### Replace my name with yours
./configure -prefix /users/jfiksel/src/ocaml
make world > log.world 2>&1
make bootstrap > log.bootstrap 2>&1  
make opt > log.opt 2>&1
make opt.opt
umask 022     
make install
cd ~/bin
ln -s ../src/ocaml/bin/ocaml ocaml
ln -s ../src/ocaml/bin/ocamlc ocamlc
ln -s ../src/ocaml/bin/ocamlopt ocamlopt
ln -s ../src/ocaml/bin/ocamlrun ocamlrun
## install unison
cd ~/Downloads
git clone https://github.com/bcpierce00/unison.git
cd unison
make UISTYLE=text
cd ~/bin
cp ~/Downloads/unison/src/unison .
```

### Option 2: Install and use linuxbrew

From https://github.com/Linuxbrew/brew/wiki/CentOS6

From log-in node request compute node with 20G of memory
```
qrsh -l mem_free=20G,h_vmem=20G
```

From compute node:
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
PATH=$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin:$PATH
HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_BUILD_FROM_SOURCE=1 brew install gcc --without-glibc
HOMEBREW_NO_AUTO_UPDATE=1 brew install glibc
brew install hello
brew install unison
```

# How to make unison profiles
Install UNISON on your local computer.  Make a text file on your LOCAL computer--here's an example

```
touch ~/.unison/cluster-example.prf
```

Then add the following lines (this will change for when you make different profiles obviously)--also make sure you replace the working directories with the appropriate ones for your project

```
root = /Users/jfiksel/Hopkins_Biostat/cluster-example
root = ssh://transfer01.jhpce.jhu.edu//users/jfiksel/cluster-example
servercmd=/users/jfiksel/bin/unison
ignore = Path {bootstrap-results*}
ignore = Name {.git}
ignore = Path {.DS_Store}
ignore = Path {.Rhistory}
ignore = Name {*.sh.o*}
ignore = Name {*.sh.po*}
ignore = Name {*.Rout}
ignore = Name {*.sh.e*}
ignore = Name {*/.git*}
ignore = Path {.Rproj*}
```

then when you want to use Unison to update the files within the cluster-example directory, simply enter

```
unison cluster-example
```

and follow the instructions

## Script for cleaning up after running batch job

Save the following as `clean.sh` in your `~/bin` directory.

```
#!/bin/bash
rm -f *~
rm -f *#
rm -f .*~
rm -f .*#
rm -f .#*
rm -f _*
##rm -f *.log
rm -f *.aux
rm -f *.sh.*
rm -f *.Rout
```

Make sure you can execute the file

```
cd ~/bin
chmod u+x clean.sh
```

Enter the following in your `~/.bash_profile`

```
alias clean='clean.sh'
```

Then you can just enter the command `clean` from a directory you just ran a batch job in
