#!/bin/bash

VM_NAME=$1
OVS_NAME=$2
VLAN_ID=$3
VNC_DISPLAY=$4   
MAC_ADDR=$5      

#crear interfaz TAP
TAP_IF="tap-${VM_NAME}"
echo "Creando interfaz $TAP_IF..."
sudo ip tuntap add dev $TAP_IF mode tap
sudo ip link set $TAP_IF up

#conectar TAP al OVS con VLAN
echo "Conectando $TAP_IF a $OVS_NAME con VLAN $VLAN_ID..."
sudo ovs-vsctl add-port $OVS_NAME $TAP_IF tag=$VLAN_ID

#lanzar VM con QEMU
echo "Lanzando VM $VM_NAME..."
qemu-system-x86_64 \
  -enable-kvm \
  -name $VM_NAME \
  -m 256 \
  -vnc 0.0.0.0:$VNC_DISPLAY \
  -netdev tap,id=${TAP_IF},ifname=$TAP_IF,script=no,downscript=no \
  -device e1000,netdev=${TAP_IF},mac=$MAC_ADDR \
  -daemonize \
  -snapshot \
  cirros-0.5.1-x86_64-disk.img

echo "VM $VM_NAME creada en VLAN $VLAN_ID (VNC :$VNC_DISPLAY → puerto $((5900+VNC_DISPLAY)))"
