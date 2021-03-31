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
   MP=multipass
else
   MP=multipass.exe
fi

# Set node names as node1, node2 etc.
NODES=`${MP} list | sed -n '2,$p' | grep node | awk '{print $1}'`

# Create multipass instances
for NODE in ${NODES}; do
	echo "starting atom on $NODE"
	$MP exec $NODE -- bash -c 'nohup ~/boomi/share/Molecule_myMolecule/bin/atom start'
done

