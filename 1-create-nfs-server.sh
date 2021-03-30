#!/bin/bash

# set cpu, memory and disk sizes for virtual machine nodes
# MEM and DISK size prefixed with K (kilobyte), M (megabyte) or G (gigabyte)
CPUS=1
MEM=1G
DISK=5G

# check if running script in windows or linux, then set command alias
if [ `uname -a | grep -iq microsoft` ]; then
   MP=multipass
else
   MP=multipass.exe
fi

# Create multipass instance for nfs server
# multipass launch --name <node name> --cpus <cpu count> --mem <memory size> --disk <disk size> 
$MP launch --name nfsserver --cpus $CPUS --mem $MEM --disk $DISK

$MP exec nfsserver -- bash -c 'sudo apt install nfs-kernel-server -y'
$MP exec nfsserver -- bash -c 'mkdir -p ~/boomi/share'
$MP exec nfsserver -- bash -c 'sudo chmod -R 777 ~/boomi/share'

IP=`$MP exec nfsserver -- bash -c "ip -4 addr show eth0" | grep inet |awk '{print $2}'`
EXPORT="\"/home/ubuntu/boomi/share ${IP}(rw,no_subtree_check,sync)\""
$MP exec nfsserver -- bash -c "echo ${EXPORT} | sudo tee -a /etc/exports"

$MP exec nfsserver -- bash -c "sudo exportfs -a && sudo service nfs-kernel-server restart"
# List instances
$MP list
