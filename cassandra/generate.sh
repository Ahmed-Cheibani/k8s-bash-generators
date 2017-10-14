#!/usr/bin/env bash

if [ "$#" -ne 3 ]; then
  echo "usage: ./generate.sh <ENV NAME> <NR ENV NAME> <NUMBER OF NODES>>"
  echo "   ie: ./generate.sh mydb sandbox 5>"
  exit
fi

envName=$1
deployEnv=$2
numberNodes=$3

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
    sed "s/\[CASSANDRA_NAME\]/${envName}/g" $template   | \
    sed "s/\[DEPLOY_ENV\]/$deployEnv/g"                 | \
    sed "s/\[NODE_ID\]/$nodeId/g"                       > \
    out/$pname$nodeId.yaml
  done

done

for template in "templates_singles"/*
do

  fname=$(basename $template)
  pname="${fname%.*}"

  sed "s/\[CASSANDRA_NAME\]/${envName}/g" $template > out/$fname

done

