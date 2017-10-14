#!/usr/bin/env bash

if [ "$#" -ne 3 ]; then
  echo "usage: ./generate.sh <ENV NAME> <NUMBER OF NODES>> <<MEM SIZE>>"
  echo "   ie: ./generate.sh myspark 5 16g>"
  exit
fi

envName=$1
numberNodes=$2
memSize=$3

# -----------------------------------------------------

cd "$(dirname "$0")"

rm -rf out
mkdir -p out

set -e

for template in "templates_multiples"/*
do

  fname=$(basename $template)
  pname="${fname%.*}"

  for ((nodeId=1; nodeId<=numberNodes; nodeId++));
  do
    sed "s/\[ENV_NAME\]/${envName}/g" $template   | \
    sed "s/\[MEM_SIZE\]/$memSize/g"               | \
    sed "s/\[NODE_ID\]/$nodeId/g"                 > \
    out/$pname$nodeId.yaml
  done

done

for template in "templates_singles"/*
do

  fname=$(basename $template)
  pname="${fname%.*}"

  sed "s/\[ENV_NAME\]/${envName}/g" $template > out/$fname

done

