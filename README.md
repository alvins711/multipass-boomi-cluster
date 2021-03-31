# Setup Boomi Molecule using Multipass

Collection of bash scripts to create a local Boomi molecule using Multipass virtual machines.

**Requirements**:
 1. Multipass installation on Windows, MacOS or Linux. See https://multipass.run/ for install instructions.
 2. Boomi AtomSphere account
 3. If running on Windows, you need to enable Windows Subsystem for Linux. See https://docs.microsoft.com/en-us/windows/wsl/install-win10


## Download scripts
 1.  git clone https://github.com/alvins711/multipass-boomi-cluster

## Deployment instructions

 1. Generate a new Molecule security token from platform.boomi.com
 2.  Copy the security token.
 3. From a terminal window execute:
			./deploy.sh \<number of nodes> \<Molecule name> \<Atomsphere security token>

If using Windows, open a Linux terminal (requires Windows Subsystem for Linux).

 The deploy.sh script will execute the following scripts in the following order:
	1-create-nfs-server.sh - Creates a multipass VM for the NFS server
	2-create-nodes.sh - Creates multipass VMs as nodes for the cluster (number of nodes  are configurable)
	3-install-boomi-molecule.sh - Installs the Boomi Molecule software on NFS server
	4-start-molecule-nodes.sh - Start Boomi atoms on each node

## Utility scripts

delete-nodes.sh - Script to delete the multipass VMs
stop-molecule-nodes.sh - Script to stop Boomi atom process on each node

## Notes:

 - Currently Multipass instances uses dynamic IP addresses, If a Multipass instance is stopped and restarted it will obtain a new IP address and NFS mounts may not be re-established.
 - The Multipass instances are currently created with 1 CPU, 1G memory and 5G of disk space. These can be changed in the scripts - 1-create-nfs-server.sh and 2-create-nodes.sh
 - 
