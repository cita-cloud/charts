#! /bin/bash

action_type=''
chain_name=''
kms_password=''
admin=''
kms_password_list=''
node_list=''
block_interval=''
block_limit=''
log_level=''
node=''
domain=''
network_image=''
consensus_image=''
kms_image=''

while getopts t:c:p:s:P:N:i:l:L:x:y:z:Q:n:d: opt; do
  case $opt in
  t)
    action_type=$OPTARG
    ;;
  c)
    chain_name=$OPTARG
    ;;
  p)
    kms_password=$OPTARG
    ;;
  s)
    admin=$OPTARG
    ;;
  P)
    kms_password_list=$OPTARG
    ;;
  N)
    node_list=$OPTARG
    ;;
  i)
    block_interval=$OPTARG
    ;;
  l)
    block_limit=$OPTARG
    ;;
  L)
    log_level=$OPTARG
    ;;
  x)
    network_image=$OPTARG
    ;;
  y)
    consensus_image=$OPTARG
    ;;
  z)
    kms_image=$OPTARG
    ;;
  Q)
    kms_password=$OPTARG
    ;;
  n)
    node=$OPTARG
    ;;
  d)
    domain=$OPTARG
    ;;
  ?)
    echo "$opt is an invalid option"
    ;;
  esac
done

index=$(ls -l /data/ | grep "^d" | grep "test-chain-[0-9]" | wc -l | awk '$1=$1')

if [ $action_type == "initMulti" ]; then
  echo "init multi cluster chain $chain_name..."
  cloud-config create-k8s --chain-name "$chain_name" \
    --config-dir "/data" \
    --admin "$admin" \
    --kms-password-list "$kms_password_list" \
    --nodelist "$node_list" \
    --block_interval "$block_interval" \
    --block_limit "$block_limit" \
    --network_image "$network_image" \
    --consensus_image "$consensus_image" \
    --kms_image "$kms_image" \
    --log-level "$log_level"
  if [ $? -ne 0 ]; then
    echo "init multi cluster chain $chain_name failed"
    exit 1
  else
    echo "init multi cluster chain $chain_name success"
    exit 0
  fi
elif [ $action_type == "increaseSingle" ]; then
  echo "append node $index..."
  cloud-config append-k8s --chain-name "$chain_name" \
    --config-dir "/data" \
    --kms-password "$kms_password" \
    --node "$chain_name-$index.$chain_name-headless-service:40000:$index"
  if [ $? -ne 0 ]; then
    echo "append node $index failed"
    exit 1
  else
    echo "append node $index success"
    exit 0
  fi
elif [ $action_type == "increaseMulti" ]; then
  echo "append node $node in multi cluster..."
  cloud-config append-k8s --chain-name "$chain_name" \
    --config-dir "/data" \
    --kms-password "$kms_password" \
    --node "$node"
  if [ $? -ne 0 ]; then
    echo "append node $node in multi cluster failed"
    exit 1
  else
    echo "append node $node in multi cluster success"
    exit 0
  fi
elif [ $action_type == "decreaseMulti" ]; then
  echo "delete node $domain in multi cluster..."
  cloud-config delete-k8s --chain-name "$chain_name" \
    --config-dir "/data" \
    --domain $domain
  if [ $? -ne 0 ]; then
    echo "delete node $domain in multi cluster failed"
    exit 1
  else
    echo "delete node $domain in multi cluster success"
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
