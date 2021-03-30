#!/bin/bash

# Check arguments and display usage if arg is missing
if [ "$#" -ne 1 ]; then
        _self="${0##*/}"
        echo "Usage: $_self <number of nodes>"
        exit
fi

# set number of virtual machine nodes to create based on input arg
NUM_NODES=$1
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

# Set node names as node1, node2 etc.
NODES=$(eval echo node{1..${NUM_NODES}})

NFSSVR=`$MP list |grep nfsserver | awk '{print $3}'`
echo "NFS server IP is: $NFSSVR"

# Create multipass instances
for NODE in ${NODES}; do 
	# multipass launch --name <node name> --cpus <cpu count> --mem <memory size> --disk <disk size> 
	$MP launch --name ${NODE} --cpus $CPUS --mem $MEM --disk $DISK
	$MP exec $NODE -- bash -c 'sudo apt install nfs-common -y'
	$MP exec $NODE -- bash -c 'sudo mkdir -p ~/boomi/share'
	$MP exec $NODE -- bash -c "sudo mount $NFSSVR:/home/ubuntu/boomi/share  ~/boomi/share"
done

# List instances
$MP list
