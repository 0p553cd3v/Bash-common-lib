#!/bin/bash

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