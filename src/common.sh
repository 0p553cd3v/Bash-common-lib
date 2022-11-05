#!/bin/bash

source /lib/sh/logging.sh
source /lib/sh/checks.sh

function wait_for_network() {
	enotify "Waiting for network:"
	until ping -c1 google.com &>/dev/null; do
		enotify "."
		sleep 1
	done
}

function check_UUID() {
        if [[ -n "$1" ]]; then
                if [[ "$1" =~ [A-Za-z0-9-] ]]; then
                        enotify "$2 UUID parsed succesfully - $1"
                else
                        eerror "Failed to parse $2 UUID - Not matching string - Value: $1"
                        exit 1
                fi
        else
                eerror "Failed to parse $2 UUID - Null value - Value: $1"
                exit 1
        fi
}

function run_func() {
	# $1 Choose function
	# 0 - check results
	# 1 - check_if_fail
	# $2 - Body of function to run
	# $3 - Common name for logging (not mandatory)
	edebug "Executing $2"
	if [ $1 -eq 0 ]; then
		$2
		check_result $3
	else
		$2
		check_if_fail
	fi
}

function run_func_return() {
	# $1 Choose function
	# 0 - check results
	# 1 - check_if_fail
	# $2 - Body of function to run
	# $3 - Common name for logging (not mandatory)
	retval=""
	edebug "Executing $2"
	if [ $1 -eq 0 ]; then
		retval=$ $2
		check_result $3
	else
		retval=$ $2
		check_if_fail
	fi
	edebug "Returning: $retval"
	echo "$retval"
}

function create_dir() {
	if [ -d "$1" ]; then
        enotify "Directory $1 exist - no actions taken"
	else
		enotify "Creating directory $1"
        mkdir $1
		check_if_fail
	fi
}

function create_sudo_dir() {
	if [ -d "$1" ]; then
        enotify "Directory $1 exist - no actions taken"
	else
		enotify "Creating directory $1"
        sudo mkdir $1
		check_if_fail
	fi
}

function create_file() {
	fullpath="$1"
	filename=${fullpath##*/}
	filedir=${fullpath//$filename/}

	edebug "File path: $fullpath"
	edebug "File name: $filename"
	edebug "File dir: $filedir"

	if [ -d "$filedir" ]; then
		enotify "Directory $filedir exist"
	else
        if [[ -n "$filedir" ]]; then
			eerror "Directory not exist $filedir"
			exit 1
		else
			enotify "NULL directory"
		fi	
	fi		
	if [ -f "$fullpath" ]; then
        enotify "File $fullpath exist - no actions taken"
	else
		enotify "Creating empty file $fullpath"
        touch $fullpath
		check_if_fail
	fi
}

function create_file_sudo() {
	fullpath="$1"
	filename=${fullpath##*/}
	filedir=${fullpath//$filename/}

	edebug "File path: $fullpath"
	edebug "File name: $filename"
	edebug "File dir: $filedir"

	if [ -d "$filedir" ]; then
		enotify "Directory $filedir exist"
	else
        if [[ -n "$filedir" ]]; then
			eerror "Directory not exist $filedir"
			exit 1
		else
			enotify "NULL directory"
		fi	
	fi		
	if [ -f "$fullpath" ]; then
        enotify "File $fullpath exist - no actions taken"
	else
		enotify "Creating empty file $fullpath"
        sudo touch $fullpath
		check_if_fail
	fi
}

function copy_file() {
	src_fullpath="$1"
	src_filename=${src_fullpath##*/}
	src_filedir=${src_fullpath//$src_filename/}
	dst_filedir="$2"
    dst_fullpath="$dst_filedir/$src_filename"

	edebug "Source file path: $src_fullpath"
	edebug "Source file name: $src_filename"
	edebug "Source file dir: $src_filedir"
	edebug "Destination file path: $dst_fullpath"
	edebug "Destination file dir: $dst_filedir"


	if [ -d "$dst_filedir" ]; then
		enotify "Destination directory $dst_filedir exist"
	else
        if [[ -n "$dst_filedir" ]]; then
			eerror "Destination directory not exist $dst_filedir"
			exit 1
		else
			eerror "NULL directory"
			exit 1
		fi	
	fi		
	if [ -f "$dst_fullpath" ]; then
        enotify "File $dst_fullpath exist - no actions taken"
	else
		enotify "Copying file $src_fullpath to $dst_filedir"
        cp $src_fullpath $dst_filedir
		check_if_fail
	fi
}

function copy_file_sudo() {
	src_fullpath="$1"
	src_filename=${src_fullpath##*/}
	src_filedir=${src_fullpath//$src_filename/}
	dst_filedir="$2"
    dst_fullpath="$dst_filedir/$src_filename"

	edebug "Source file path: $src_fullpath"
	edebug "Source file name: $src_filename"
	edebug "Source file dir: $src_filedir"
	edebug "Destination file path: $dst_fullpath"
	edebug "Destination file dir: $dst_filedir"

	if [ -d "$dst_filedir" ]; then
		enotify "Destination directory $dst_filedir exist"
	else
        if [[ -n "$dst_filedir" ]]; then
			eerror "Destination directory not exist $dst_filedir"
			exit 1
		else
			eerror "NULL directory"
			exit 1
		fi	
	fi		
	if [ -f "$dst_fullpath" ]; then
        enotify "File $dst_fullpath exist - no actions taken"
	else
		enotify "Copying file $src_fullpath to $dst_filedir"
        sudo cp $src_fullpath $dst_filedir
		check_if_fail
	fi
}

function add_line_to_file() {

	edebug "Line to be added: $1"
	edebug "File path: $2"
	edebug "Line prefix: $3"

	if [ -f "$2" ]; then
		count="$(grep -c "$3" $2)"
		edebug "Prefix matches count: $count"
		if [[ "$count" -eq "0" ]]; then
			enotify "Line prefix $3 not found"
			enotify "Adding $1 to file $2"
			echo $1 >> $2
			check_if_fail	
		elif [[ "$count" -eq "1" ]]; then	
			line="$(grep "$3" $2)"
			enotify "Line prefix $3 found"
			enotify "Appending line $line with $1" 	
			sed -i "s|^$3.*|$1|" $2
			check_if_fail		
		else			
			eerror "Multiple ($count) matches for prefix $3"
			exit 1
		fi
	else
		eerror "File $2 not exist"
		exit 1
	fi
}

function add_line_to_file_sudo() {

	edebug "Line to be added: $1"
	edebug "File path: $2"
	edebug "Line prefix: $3"

	if [ -f "$2" ]; then
		count="$(grep -c "$3" $2)"
		edebug "Prefix matches count: $count"
		if [[ "$count" -eq "0" ]]; then
			enotify "Line prefix $3 not found"
			enotify "Adding $1 to file $2"
			sudo echo $1 >> $2
			check_if_fail	
		elif [[ "$count" -eq "1" ]]; then	
			line="$(grep "$3" $2)"
			enotify "Line prefix $3 found"
			enotify "Appending line $line with $1" 	
			sudo sed -i "s|^$3.*|$1|" $2
			check_if_fail		
		else				
			eerror "Multiple ($count) matches for prefix $3"
			exit 1
		fi
	else
		eerror "File $2 not exist"
		exit 1
	fi
}