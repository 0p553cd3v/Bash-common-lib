#!/bin/bash

#Create catalogue for shell libraries 
sudo mkdir /lib/sh

#Create catalogue for git repo 
sudo mkdir $USER/Git

git clone https://github.com/0p553cd3v/Bash-common-lib $USER/Git

sudo cp $USER/Git/Bash-common-lib/src/common.sh /lib/sh
sudo cp $USER/Git/Bash-common-lib/src/logging.sh /lib/sh

#Add libs to current shell
export PATH=/lib/sh:$PATH
#Add libs permanently
sudo echo -e "export PATH=/lib/sh:$PATH" >> ~/.bash_profile
. .bash_profile
