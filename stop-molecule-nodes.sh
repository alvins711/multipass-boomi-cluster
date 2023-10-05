#!/bin/bash

###################################################################
#Script Name    :  4-start-molecule-nodes.sh
#Description    :  start molecule on each node
#Args           :  
#Author         :  Alvin Salalila
#Email          :
###################################################################


# check if running script in windows or linux, then set command alias
if [ `uname -a | grep -iq microsoft` ]; then
   MP=multipass.exe
else
   MP=multipass
fi

# Set node names as node1, node2 etc.
NODES=`${MP} list | sed -n '2,$p' | grep node | awk '{print $1}'`
NODES="${NODES} nfssvr"

# Create multipass instances
for NODE in ${NODES}; do
	echo "stopping atom on $NODE"
	$MP exec $NODE -- bash -c 'nohup ~/boomi/share/Molecule_myMolecule/bin/atom stop'
done

