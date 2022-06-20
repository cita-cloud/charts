#! /bin/bash

action_type=''
chain_name=''

while getopts t:c: opt; do
  case $opt in
  t)
    action_type=$OPTARG
    ;;
  c)
    chain_name=$OPTARG
    ;;
  ?)
    echo "$opt is an invalid option"
    ;;
  esac
done

index=$(ls -l /data/ | grep "^d" | grep "$chain_name-[0-9]" | wc -l | awk '$1=$1')

if [ $action_type == "increaseSingle" ]; then
  echo "append node $index..."
  cloud-config append-k8s --chain-name "$chain_name" \
    --config-dir "/data" \
    --node "$chain_name-$index.$chain_name-headless-service:40000:$index"
  if [ $? -ne 0 ]; then
    echo "append node $index failed"
    exit 1
  else
    echo "append node $index success"
    exit 0
  fi
elif [ $action_type == "decreaseSingle" ]; then
  # in this type, domain is calculated
  domain=$(expr $index - 1)
  echo "delete node $domain..."
  cloud-config delete-k8s --chain-name "$chain_name" \
    --config-dir "/data" \
    --domain $domain
  if [ $? -ne 0 ]; then
    echo "delete node $domain failed"
    exit 1
  else
    echo "delete node $domain success"
    exit 0
  fi
elif [ $action_type == "clean" ]; then
  echo "clean chain $chain_name..."
  cloud-config delete-chain --chain-name "$chain_name" \
    --config-dir "/data"
  if [ $? -ne 0 ]; then
    echo "clean chain $chain_name failed"
    exit 1
  else
    echo "clean chain $chain_name success"
    exit 0
  fi
fi
