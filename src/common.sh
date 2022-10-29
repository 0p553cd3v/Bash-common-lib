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
	edebug "Executing $2"
	if [ $1 -eq 0 ]; then
		$2
		check_result $3
	else
		$2
		check_if_fail $2
	fi
}

function create_dir() {
	if [ -d "$1" ]; then
                enotify "Directory $1 exist - no actions taken"
                exit 0
	else
		enotify "Creating directory $1"
                mkdir $1
		check_if_fail
	fi
}

function create_sudo_dir() {
	if [ -d "$1" ]; then
                enotify "Directory $1 exist - no actions taken"
                exit 0
	else
		enotify "Creating directory $1"
                sudo mkdir $1
		check_if_fail
	fi
}