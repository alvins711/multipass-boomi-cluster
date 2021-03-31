#!/usr/bin/bash

# Check arguments and display usage if arg is missing
if [ "$#" -ne 3 ]; then
        _self="${0##*/}"
        echo "Usage: $_self <number of nodes> <Molecule name> <Atomsphere security token>"
        exit
fi

# set up variables from args
NUMNODES=$1
MOLECULE_NAME=$2
AS_SEC_TOKEN=$3

# Create NFS server
echo " Creating NFS server..."
./1-create-nfs-server.sh
# Create molecule nodes
echo "Creating Nodes..."
./2-create-nodes.sh $NUMNODES
# Install Boomi molecule on nfs server
echo "Installing Boomi Molecule on server..."
./3-install-boomi-molecule.sh $MOLECULE_NAME $AS_SEC_TOKEN
# start molecule atoms on nodes
echo "Starting atoms on molecule nodes..."
./4-start-molecule-nodes.sh 

echo "Done!"
