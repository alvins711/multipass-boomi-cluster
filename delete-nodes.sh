#!/usr/bin/bash


# check if running script in windows or linux, then set command alias
if [ `uname -a | grep -iq microsoft` ]; then
	   MP=multipass
   else
	   MP=multipass.exe
fi

# Get list of node names, note this will delete all multipass instances
NODES=`${MP} list | sed -n '2,$p' | grep node | awk '{print $1}'`
NODE="${NODES} nfssvr"

# for each node delete multipass instance
for i in $NODES; do
	echo "deleting ${i}"
	${MP} delete $i
done

$MP purge
