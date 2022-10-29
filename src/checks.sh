#!/bin/bash

source /lib/sh/logging.sh

function check_result() {
	if [ $? -eq 0 ]; then 
	  eok $1
	else 
	  eerror $1
	  exit 1
	fi
}

function check_if_fail() {
	if [ $? -ne 0 ]; then 
	  eerror $1
	  exit 1
	fi
}

function warn_if_fail() {
	if [ $? -ne 0 ]; then 
	  ewarn $1
	fi
}

