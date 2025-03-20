#!/usr/bin/env bash

if ! sensors >/dev/null 2>&1;then
  echo "Error: 'sensors' command not found"
  exit 1
fi

nodes=$(pbsnodes -a | grep "Mom = " | awk '{print $3}')
for node in $nodes;do
  echo -e "${KCYN}Highest Temperature of ${KGRN}$node${KNRM}"
  # ssh $node "sensors" # all temperature
  ssh "$node" "sensors | grep 'Core' | sort -k3 | tail -n 1" # highest temperature
done
