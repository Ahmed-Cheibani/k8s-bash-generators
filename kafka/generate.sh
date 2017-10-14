#!/usr/bin/env bash

if [ "$#" -ne 3 ]; then
  echo "usage: ./generate.sh <ENV NAME> <ZOO PREF> <NUMBER OF NODES>>"
  echo "   ie: ./generate.sh sandbox sandbox-zoo 5>"
  exit
fi

envName=$1
zooPref=$2
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

  END=$numberNodes
  for ((brokerId=1;brokerId<=END;brokerId++));
  do
    sed "s/\[ENV_NAME\]/${envName}/g" $template   | \
    sed "s/\[BROKER_ID\]/$brokerId/g"             | \
    sed "s/\[ZOO_PREF\]/${zooPref}/g"               \
    > out/$pname$brokerId.yaml
  done

done

for template in "templates_singles"/*
do

  fname=$(basename $template)
  pname="${fname%.*}"

  sed "s/\[ENV_NAME\]/${envName}/g" $template | \
  sed "s/\[ZOO_PREF\]/${zooPref}/g" > out/$fname

done

