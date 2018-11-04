#!/bin/bash

set -e

status=$(nc -z miniondatabase 5432; echo $?)
while [ $status != 0 ]
do
  sleep 3s
  status=$(nc -z miniondatabase 5432; echo $?)
  echo 'Waiting for miniondatabase to spin up before running worker.'
done

# Run Minion Worker
perl -Mlocal::lib=local script/basic_app minion worker
