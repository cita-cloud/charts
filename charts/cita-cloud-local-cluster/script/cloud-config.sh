#! /bin/bash
chain_name=''
admin=''
kms_password_list=''
replica_count=''
block_interval=''
block_limit=''
network_image=''
consensus_image=''
kms_image=''

while getopts c:a:k:r:i:l:x:y:z: opt; do
  case $opt in
  c)
    chain_name=$OPTARG
    ;;
  a)
    admin=$OPTARG
    ;;
  r)
    replica_count=$OPTARG
    ;;
  i)
    block_interval=$OPTARG
    ;;
  l)
    block_limit=$OPTARG
    ;;
  x)
    network_image=$OPTARG
    ;;
  y)
    consensus_image=$OPTARG
    ;;
  z)
    crypto_image=$OPTARG
    ;;
  ?)
    echo "$opt is an invalid option"
    ;;
  esac
done

if [ -d "/data/$chain_name" ]; then
  echo "already initialized"
  exit 0
fi

node_list=''

i=0
while [ $i -lt "$replica_count" ]; do
  node_list=$node_list$chain_name"-$i.$chain_name-headless-service:40000:$i:k8s,"
  # shellcheck disable=SC2004
  i=$(($i + 1))
done
# shellcheck disable=SC2001
node_list=$(echo "$node_list" | sed s'/.$//')

cloud-config create-k8s --chain-name "$chain_name" \
  --config-dir "/data" \
  --admin "$admin" \
  --nodelist "$node_list" \
  --block_interval "$block_interval" \
  --block_limit "$block_limit" \
  --network_image "$network_image" \
  --consensus_image "$consensus_image" \
  --crypto_image "$crypto_image"
