# psortb_commandline_docker

### PSORTb
PSORTb is a bioinformatics tool for predicting subcellular 
localization for a given set of protein sequences. The protein 
sequences must belong to one type of organisms, classified by 
cell membrane type in order to more accurately predict subcellular 
localization. The supported organism types are: 
- Gram negative (-n)
- Gram positive (-p)
- archaea (-a)   
- Gram negative without outer membrane
- Gram positive with outer membrane

The PSORTb program has been added to a Docker container to
simply the installation process.

This PSORTb installations uses PSORTb version 3.


### Repository contents
This repository hosts a Docker buildfile (Dockerfile) which builds the complex
environment of PSORTb. It also contains a wrapper script (named psortb) to
run the PSORTb analysis inside the Docker container.

Warning: Users of this app must have admin rights to run docker commands.
Either that or an administrator must give you access to run "docker run"
commands.


### Pre-built Docker image
A pre-built image created by the Dockerfile in this repository can be 
found at https://hub.docker.com/r/brinkmanlab/psortb_commandline/


### Building this app
You can build the Docker image yourself using the following instructions. 
This build requires a unix-type system and 3.9GB space. 
```
% git clone https://github.com/brinkmanlab/psortb_commandline_docker.git
% cd psortb_commandline_docker
% sudo docker build --rm --no-cache -t psortb_commandline_docker .
```


### Running a PSORTb analysis
Once the Docker image has been installed, run PSORTb like this:
```
% cd psortb_commandline_docker
% ./psortb -h
```

Warning: Users of this psortb app must have admin rights to run 
docker commands. Either that or an administrator must give you 
access to run "docker run" commands.

```
% ./psortb -i <FASTA format sequence file> -r <local results directory>
```


### License
PSORTb is distributed under [GNU General Public License Version 3](https://github.com/brinkmanlab/psortm-docker/blob/master/LICENSE).

### Support
Please email any questions to psort-mail@sfu.ca

This application was developed by Gemma Hoad in the Brinkman Laboratory at Simon Fraser University, Greater Vancouver, Canada.

