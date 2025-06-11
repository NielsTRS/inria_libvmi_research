#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <vm_name>"
  exit 1
fi

while true; do
  sudo vmi-process-list -n $1
  sleep 1
done
