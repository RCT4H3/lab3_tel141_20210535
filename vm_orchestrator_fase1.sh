#!/bin/bash

echo "=== Iniciando Orquestador Fase 1 (HeadNode) ==="

# Credenciales
USER="ubuntu"
PASSWORD="carlos3105"

WORKER1_IP=10.0.10.2   #server2
WORKER2_IP=10.0.10.3   #server3
WORKER3_IP=10.0.10.4   #server4
OFS_IP=10.0.10.5       #ofs

sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no $USER@$WORKER1_IP "bash -s" < ./init_worker.sh br-int ens4
sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no $USER@$WORKER2_IP "bash -s" < ./init_worker.sh br-int ens4
sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no $USER@$WORKER3_IP "bash -s" < ./init_worker.sh br-int ens4

sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no $USER@$OFS_IP "bash -s" < ./init_ofs.sh br-ofs ens4 ens5 ens6

echo "=== Creando VMs en Worker1 (server2) ==="
sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no $USER@$WORKER1_IP "bash -s" < ./vm_create.sh vm1 br-int 100 1 20:21:05:35:ee:01
sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no $USER@$WORKER1_IP "bash -s" < ./vm_create.sh vm2 br-int 200 2 20:21:05:35:ee:02
sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no $USER@$WORKER1_IP "bash -s" < ./vm_create.sh vm3 br-int 300 3 20:21:05:35:ee:03

echo "=== Creando VMs en Worker2 (server3) ==="
sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no $USER@$WORKER2_IP "bash -s" < ./vm_create.sh vm4 br-int 100 4 20:21:05:35:ee:04
sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no $USER@$WORKER2_IP "bash -s" < ./vm_create.sh vm5 br-int 200 5 20:21:05:35:ee:05
sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no $USER@$WORKER2_IP "bash -s" < ./vm_create.sh vm6 br-int 300 6 20:21:05:35:ee:06

echo "=== Creando VMs en Worker3 (server4) ==="
sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no $USER@$WORKER3_IP "bash -s" < ./vm_create.sh vm7 br-int 100 7 20:21:05:35:ee:07
sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no $USER@$WORKER3_IP "bash -s" < ./vm_create.sh vm8 br-int 200 8 20:21:05:35:ee:08
sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no $USER@$WORKER3_IP "bash -s" < ./vm_create.sh vm9 br-int 300 9 20:21:05:35:ee:09

echo "=== Orquestador fase 1 desplegado ==="
