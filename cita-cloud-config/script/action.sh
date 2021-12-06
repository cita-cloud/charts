#! /bin/bash

action=''
chain_name=''
kms_password=''
admin=''
block_interval=''
block_limit=''
node_list=''
node=''
domain=''
network_image=''
consensus_image=''
kms_image=''

while getopts a:c:p:s:i:l:n:m:d:x:y:z: opt; do
  case $opt in
  a)
    action=$OPTARG
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
  i)
    block_interval=$OPTARG
    ;;
  l)
    block_limit=$OPTARG
    ;;
  n)
    node_list=$OPTARG
    ;;
  m)
    node=$OPTARG
    ;;
  d)
    domain=$OPTARG
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
  ?)
    echo "$opt is an invalid option"
    ;;
  esac
done

count=$(ls -l /data/ | grep "^d" | grep "$chain_name-*" | wc -l | awk '$1=$1')
index=''
if [ $action == "increase" ] || [ $action == "decrease" ]; then
  # index only for local cluster
  index=$(expr $count - 1)
fi

if [ $action == "init-multi" ]; then
  echo "init multi cluster chain $chain_name..."
  cloud-config create-k8s --chain-name "$chain_name" \
    --config-dir "/data" \
    --admin "$admin" \
    --kms-password-list "$kms_password" \
    --nodelist "$node_list" \
    --block_interval "$block_interval" \
    --block_limit "$block_limit" \
    --network_image "$network_image" \
    --consensus_image "$consensus_image" \
    --kms_image "$kms_image"
  if [ $? -ne 0 ]; then
    echo "init multi cluster chain $chain_name failed"
    exit 1
  else
    echo "init multi cluster chain $chain_name success"
    exit 0
  fi
elif [ $action == "increase" ]; then
  echo "append node $index..."
  cloud-config append-k8s --chain-name "$chain_name" \
    --config-dir "/data" \
    --kms-password "$kms_password" \
    --node "$chain_name-$index.$chain_name-headless-service.default:40000:$index"
  if [ $? -ne 0 ]; then
    echo "append node $index failed"
    exit 1
  else
    echo "append node $index success"
    exit 0
  fi
elif [ $action == "increase-multi" ]; then
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
elif [ $action == "decrease-multi" ]; then
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
elif [ $action == "decrease" ]; then
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
fi
