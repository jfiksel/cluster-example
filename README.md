# How to install UNISON on cluster

```
cd ~/Downloads/ocaml-4.06.1
./configure -prefix /users/rscharpf/src/ocaml
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
