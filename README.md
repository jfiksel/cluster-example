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


## How to use Unison for file transfer and syncing
Install UNISON on your local computer--make sure that you have the same version as the one currently installed on the cluster.
To check the cluster version, we first need to make sure we have access to the cluster-wide installation of Unison. from a log-in node enter:

```
which unison
```

The output of this should be `/jhpce/shared/jhpce/core/JHPCE_tools/1.0/bin/unison`. Then enter

```
unison -version
```

The output should be `unison version <unison-version> (ocaml <ocaml-version>)`

where `<unison-version>` and `<ocaml-version>` are actual version numbers. For example, at the time of writing this guide, my output is:

`unison version 2.51.2 (ocaml 4.07.1)`

Your local version of unison should match `<unison-version>`, but it does not have to match `<ocaml-version>`.


Now make a unison profile for your project on your LOCAL computer--here's how you can initiate a blank `.prf` file.

```
touch ~/.unison/cluster-example.prf
```
You will have to do this for each directory you want to sync via Unison. However, every file and sub-directory within a project directory will automatically be synked.

Then add the following lines using the text editor of choice (this will change for when you make different profiles obviously)--also make sure you replace the working directories with the appropriate ones for your project

```
root = local/path/to/cluster-example
root = ssh://jhpce-transfer01.jhsph.edu//cluster/path/to/cluster-example
servercmd=/jhpce/shared/jhpce/core/JHPCE_tools/1.0/bin/unison
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

In the above, on my computer, I have `local/path/to/cluster-example` replaced with `/Users/jfiksel/Hopkins_Biostat/cluster-example` and `ssh://jhpce-transfer01.jhsph.edu//cluster/path/to/cluster-example` replaced with `ssh://jhpce-transfer01.jhsph.edu//users/jfiksel/cluster-example`.  Please note that for small amounts of data (less than a couple of GB), you can use `jhpce01.jhsph.edu` (in the second root line).  However, for transferring large amounts of data, it will be much faster to use `jhpce-transfer01.jhsph.edu` (as I have above).  IMPORTANT NOTE: If you do use `jhpce-transfer01.jhsph.edu` you will need to email bitsupport and request to have your user ID added to the “ssh allow list” for jhpce-transfer01.


then when you want to use Unison to update the files within the cluster-example directory, simply enter

```
unison cluster-example
```

and follow the instructions. Now every file and directory within your local `cluster-example` will be synked to the cluster version of `cluster-example`.

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
