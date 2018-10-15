# How to install UNISON on cluster

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


