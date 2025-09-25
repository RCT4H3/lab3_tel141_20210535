#!/bin/bash

OVS_NAME=$1
shift
INTERFACES=$@

#verificar que OVS este instalado
if ! command -v ovs-vsctl &> /dev/null; then
  echo "Open vSwitch no está instalado. Instalando..."
  sudo apt update && sudo apt install -y openvswitch-switch
fi

#crear bridge si no existe
if ! ovs-vsctl br-exists $OVS_NAME; then
  echo "Creando bridge $OVS_NAME..."
  sudo ovs-vsctl add-br $OVS_NAME
else
  echo "Bridge $OVS_NAME ya existe"
fi

#conectar interfaces físicas al OVS
for IFACE in $INTERFACES; do
  echo "Reseteando $IFACE y agregándola a $OVS_NAME..."
  sudo ip addr flush dev $IFACE
  sudo ip link set $IFACE up
  sudo ovs-vsctl add-port $OVS_NAME $IFACE
done

echo "OFS inicializado con $OVS_NAME"
ovs-vsctl show
