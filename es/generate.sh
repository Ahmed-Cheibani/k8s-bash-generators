#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
  echo "usage: ./generate.sh <ENV NAME>"
  echo "   ie: ./generate.sh myes"
  exit
fi

envName=$1

# -----------------------------------------------------

cd "$(dirname "$0")"

rm -rf out
mkdir -p out

set -e

for template in "templates_singles"/*
do

  fname=$(basename $template)
  pname="${fname%.*}"

  sed "s/\[ENV_NAME\]/${envName}/g" $template > out/$fname

done

