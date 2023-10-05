#!/bin/bash

###################################################################
#Script Name	:  1-create-nfs-server.sh                                                                                            
#Description	:  Creates multipass instance and sets up NFS server share                                                                               
#Args          	:                                                                                           
#Author       	:Alvin Salalila                                                
#Email         	:                                           
###################################################################


# check if running script in windows or linux, then set command alias
if [ `uname -a | grep -iq microsoft` ]; then
   MP=multipass.exe
else
   MP=multipass
fi

# set cpu, memory and disk sizes for virtual machine nodes
# MEM and DISK size prefixed with K (kilobyte), M (megabyte) or G (gigabyte)
CPUS=1
MEM=1G
DISK=5G

# Create multipass instance for master (nfs server)
# multipass launch --name <node name> --cpus <cpu count> --mem <memory size> --disk <disk size> 
$MP launch --name nfssvr --cpus $CPUS --memory $MEM --disk $DISK

$MP exec nfssvr -- bash -c 'sudo apt install nfs-kernel-server -y'
$MP exec nfssvr -- bash -c 'mkdir -p ~/boomi/share'
$MP exec nfssvr -- bash -c 'sudo chmod -R 777 ~/boomi/share'

IP=`$MP exec nfssvr -- bash -c "ip -4 addr show eth0" | grep inet |awk '{print $2}'`
EXPORT="\"/home/ubuntu/boomi/share ${IP}(rw,insecure,no_subtree_check,nohide,fsid=0,sync,no_root_squash)\""
#EXPORT="\"/home/ubuntu/boomi/share ${IP}(rw,no_subtree_check,sync)\""

$MP exec nfssvr -- bash -c "echo ${EXPORT} | sudo tee -a /etc/exports"

$MP exec nfssvr -- bash -c "sudo exportfs -a && sudo service nfs-kernel-server restart"
# List instances
$MP list
