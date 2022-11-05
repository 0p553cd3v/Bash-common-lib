#!/bin/bash

source /lib/sh/logging.sh
source /lib/sh/checks.sh

function config_count_records_GGA (){
  # $1 - Config file path
  # $2 - Group
  # $3 - Select field name 
  # $4 - Value array name
  retval=""
  edebug "Arg 1: $1"
  edebug "Arg 2: $2"
  edebug "Arg 3: $3"
  edebug "Arg 4: $4"
  edebug "Running function: run_func_return 1 $(jq ".$2.$3 | .$4 | length" $1)" 
  retval= run_func_return 1 "jq '.$2.$3 | .$4 | length' $1 "
  edebug "Returning: $retval"
  echo "$retval"
}

function config_count_records_GSA (){
  # $1 - Config file path
  # $2 - Group
  # $3 - Select field name 
  # $4 - Select field value
  # $5 - Value array name
  retval=""
  edebug "Arg 1: $1"
  edebug "Arg 2: $2"
  edebug "Arg 3: $3"
  edebug "Arg 4: $4"
  edebug "Arg 5: $5"
  edebug "Running function: $( run_func_return 1 "$(jq '.$2[] | select(.$3=="$4") | .$5 | length' $1)" )"
  retval=$( run_func_return 1 "$(jq '.$2[] | select(.$3=="$4") | .$5 | length' $1)" )
  edebug "Returning: $retval"
  echo "$retval"
}

function config_read_value_GSF (){
  # $1 - Config file path
  # $2 - Group
  # $3 - Select field name 
  # $4 - Select field value
  # $5 - Value field name
  retval=""
  edebug "Arg 1: $1"
  edebug "Arg 2: $2"
  edebug "Arg 3: $3"
  edebug "Arg 4: $4"
  edebug "Arg 5: $5"
  edebug "Running function: $( run_func 1 "$(jq '.$2[] | select(.$3=="$4") | .$5' $1)" )"
  retval=$( run_func 1 "$(jq '.$2[] | select(.$3=="$4") | .$5' $1)" )
  edebug "Returning: $retval"
  echo "$retval"
}

function config_read_value_GSA (){
  # $1 - Config file path
  # $2 - Group
  # $3 - Select field name 
  # $4 - Select field value
  # $5 - Value array name
  # $6 - Value array index
  retval=""
  edebug "Arg 1: $1"
  edebug "Arg 2: $2"
  edebug "Arg 3: $3"
  edebug "Arg 4: $4"
  edebug "Arg 5: $5"
  edebug "Arg 6: $6"
  edebug "Running function: $( run_func 1 "$(jq '.$2[] | select(.$3=="$4") | .$5[$6]' $1)" )"
  retval=$( run_func 1 "$(jq '.$2[] | select(.$3=="$4") | .$5[$6]' $1)" )
  edebug "Returning: $retval"
  echo "$retval"
}

function config_read_number_value_GGA (){
  # $1 - Config file path
  # $2 - Group
  # $3 - Select field name 
  # $4 - Value array name
  # $5 - Value array index
  retval=""
  edebug "Arg 1: $1"
  edebug "Arg 2: $2"
  edebug "Arg 3: $3"
  edebug "Arg 4: $4"
  edebug "Arg 5: $5"
  edebug "Running function: $( run_func 1 "$(jq '.$2.$3 | .$4[$5]' | tonumber $1)" )"
  retval=$( run_func 1 "$(jq '.$2.$3 | .$4[$5]' | tonumber $1)" )
  edebug "Returning: $retval"
  echo "$retval"
}
