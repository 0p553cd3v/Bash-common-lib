#!/bin/bash

source /lib/sh/logging.sh
source /lib/sh/checks.sh

function docker_run_func() {
	# $1 Choose function
	# 0 - check results
	# 1 - check_if_fail
	# $2 - Body of function to run
	# $3 - Container name
	# $4 - Common name for logging (not mandatory)
	edebug "Executing $2"
	if [ $1 -eq 0 ]; then
		docker exec $3 $2 
		check_result $4
	else
		docker exec $3 $2 
		check_if_fail
	fi
}