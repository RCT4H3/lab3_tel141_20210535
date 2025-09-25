#!/bin/bash

#credenciales para acceder a los nodos por ssh
HOST_IP="10.20.12.187"
USER="ubuntu"
PASSWORD="carlos3105"

#puertos ssh de cada host
WORKER1_PORT=5802   #server2
WORKER2_PORT=5803   #server3
WORKER3_PORT=5804   #server4
OFS_PORT=5805       #ofs
HEADNODE_PORT=5801  #server1 

#inicializar Workers
sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no -p $WORKER1_PORT $USER@$HOST_IP "bash -s" < ./init_worker.sh br-int ens4
sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no -p $WORKER2_PORT $USER@$HOST_IP "bash -s" < ./init_worker.sh br-int ens4
sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no -p $WORKER3_PORT $USER@$HOST_IP "bash -s" < ./init_worker.sh br-int ens4

#Inicializar OFS
sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no -p $OFS_PORT $USER@$HOST_IP "bash -s" < ./init_ofs.sh br-ofs ens4 ens5 ens6

#3 VMs en cada Worker
echo "=== Creando VMs en Worker1 (server2) ==="
sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no -p $WORKER1_PORT $USER@$HOST_IP "bash -s" < ./vm_create.sh vm1 br-int 10 1 20:21:05:35:ee:01
sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no -p $WORKER1_PORT $USER@$HOST_IP "bash -s" < ./vm_create.sh vm2 br-int 10 2 20:21:05:35:ee:02
sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no -p $WORKER1_PORT $USER@$HOST_IP "bash -s" < ./vm_create.sh vm3 br-int 10 3 20:21:05:35:ee:03

echo "=== Creando VMs en Worker2 (server3) ==="
sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no -p $WORKER2_PORT $USER@$HOST_IP "bash -s" < ./vm_create.sh vm4 br-int 10 4 20:21:05:35:ee:04
sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no -p $WORKER2_PORT $USER@$HOST_IP "bash -s" < ./vm_create.sh vm5 br-int 10 5 20:21:05:35:ee:05
sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no -p $WORKER2_PORT $USER@$HOST_IP "bash -s" < ./vm_create.sh vm6 br-int 10 6 20:21:05:35:ee:06

echo "=== Creando VMs en Worker3 (server4) ==="
sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no -p $WORKER3_PORT $USER@$HOST_IP "bash -s" < ./vm_create.sh vm7 br-int 20 7 20:21:05:35:ee:07
sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no -p $WORKER3_PORT $USER@$HOST_IP "bash -s" < ./vm_create.sh vm8 br-int 20 8 20:21:05:35:ee:08
sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no -p $WORKER3_PORT $USER@$HOST_IP "bash -s" < ./vm_create.sh vm9 br-int 20 9 20:21:05:35:ee:09


echo "=== Orquestador fase 1 desplegado ==="
