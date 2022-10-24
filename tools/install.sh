#!/bin/bash

#Create catalogue for shell libraries 
sudo mkdir /lib/sh

#Create catalogue for git repo 
mkdir $HOME/Git
mkdir $HOME/Git/Bash-common-lib

git clone https://github.com/0p553cd3v/Bash-common-lib.git $HOME/Git/Bash-common-lib

sudo cp $HOME/Git/Bash-common-lib/src/common.sh /lib/sh
sudo cp $HOME/Git/Bash-common-lib/src/logging.sh /lib/sh