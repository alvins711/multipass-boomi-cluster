#!/bin/bash

###################################################################
#Script Name    :  3-install-boomi-molecule.sh
#Description    :  installs boomi molecule on  NFS server node
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

# Check arguments and display usage if arg is missing
if [ "$#" -ne 2 ]; then
        _self="${0##*/}"
        echo "Usage: $_self <Molecule name> <AtomSphere security token>"
        exit
fi

# Molecule name
MOLECULENAME=$1
# Atomsphere security token
SECTOKEN=$2

# NFS server node name
NFSNODE=nfssvr

$MP exec $NFSNODE -- bash -c 'wget https://platform.boomi.com/atom/molecule_install64.sh'
$MP exec $NFSNODE -- bash -c 'sudo chmod 755 ~/molecule_install64.sh'
$MP exec $NFSNODE -- bash -c "./molecule_install64.sh -q -console -VatomName=$MOLECULENAME -VinstallToken=$SECTOKEN -dir ~/boomi/share"

