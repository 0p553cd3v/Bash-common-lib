#!/bin/bash

source /lib/sh/logging.sh
source /lib/sh/checks.sh

function config_count_records_GGA (){
  # $1 - Config file path
  # $2 - Group
  # $3 - Select field name 
  # $4 - Select field value
  # $5 - Value array name
  retval=""
  retval=$( run_func_return 1 "$(jq '.$2[] | select(.$3=="$4") | .$5 | length' $1)" )
  echo "$retval"
}

function config_read_value_GSF (){
  # $1 - Config file path
  # $2 - Group
  # $3 - Select field name 
  # $4 - Select field value
  # $5 - Value field name
  retval=""
  retval=$( run_func 1 "$(jq '.$2[] | select(.$3=="$4") | .$5' $1)" )
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
  retval=$( run_func 1 "$(jq '.$2[] | select(.$3=="$4") | .$5[$6]' $1)" )
  echo "$retval"
}
