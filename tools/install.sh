#!/bin/bash

#Create catalogue for shell libraries 
sudo mkdir /lib/sh

#Create catalogue for git repo 
mkdir $HOME/Git
mkdir $HOME/Git/Bash-common-lib

if [[ -n "$1" ]]; then
    echo -e "Git checkout to branch: $1"
    git clone https://github.com/0p553cd3v/Bash-common-lib.git $HOME/Git/Bash-common-lib -b $1 --depth 1
else
    echo -e "No branch specified - Git checkout to branch: master"
    git clone https://github.com/0p553cd3v/Bash-common-lib.git $HOME/Git/Bash-common-lib
fi

sudo cp $HOME/Git/Bash-common-lib/src/common.sh /lib/sh
sudo cp $HOME/Git/Bash-common-lib/src/logging.sh /lib/sh
sudo cp $HOME/Git/Bash-common-lib/src/checks.sh /lib/sh
sudo cp $HOME/Git/Bash-common-lib/src/configs.sh /lib/sh