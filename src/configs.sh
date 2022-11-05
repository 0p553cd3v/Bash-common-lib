#!/bin/bash

source /lib/sh/logging.sh
source /lib/sh/checks.sh

function config_count_records_GGA (){
  # $1 - Config file path
  # $2 - Group
  # $3 - Select field name 
  # $4 - Value array name
  retval=""
  retval=$(jq -r ".$2.$3.$4 | length" $1)
  check_if_fail
  echo "$retval"
}

function config_count_records_GSA (){
  # $1 - Config file path
  # $2 - Group
  # $3 - Select field name 
  # $4 - Select field value
  # $5 - Value array name
  retval=""
  retval=$(jq -r ".$2[] | select(.$3==$4) | .$5 | length" $1)
  check_if_fail
  echo "$retval"
}

function config_read_value_GSF (){
  # $1 - Config file path
  # $2 - Group
  # $3 - Select field name 
  # $4 - Select field value
  # $5 - Value field name
  retval=""
  retval=$(jq -r ".$2[] | select(.$3==$4) | .$5" $1)
  check_if_fail
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
  retval=$(jq -r ".$2[] | select(.$3==$4) | .$5[$6]" $1)
  check_if_fail
  echo "$retval"
}

function config_read_number_value_GGA (){
  # $1 - Config file path
  # $2 - Group
  # $3 - Select field name 
  # $4 - Value array name
  # $5 - Value array index
  retval=""
  retval=$(jq -r ".$2.$3.$4[$5]" | tonumber $1)
  check_if_fail
  echo "$retval"
}
