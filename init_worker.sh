#!/bin/bash

OVS_NAME=$1
shift
INTERFACES=$@



if ! ovs-vsctl br-exists $OVS_NAME; then
  echo "Creando bridge $OVS_NAME..."
  sudo ovs-vsctl add-br $OVS_NAME
else
  echo "Bridge $OVS_NAME ya existe"
fi

for IFACE in $INTERFACES; do
  echo "Conectando $IFACE a $OVS_NAME..."
  sudo ip addr flush dev $IFACE     
  sudo ip link set $IFACE up
  sudo ovs-vsctl add-port $OVS_NAME $IFACE
done

echo "Worker inicializado con $OVS_NAME"
ovs-vsctl show
