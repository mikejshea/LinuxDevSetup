#!/bin/bash
WAIT_TIME=10

if [ "$1" == "" ]; then
    echo "Must include snapshot name."
    exit
fi

if [ "$2" != "" ]; then
  WAIT_TIME=$2
fi

SNAPSHOT=$1

echo Stopping VMs...
# vmrun stop "/mnt/md0/vms/gpd-mdb-1/gpd-mdb-1.vmx"
# vmrun stop "/mnt/md0/vms/gpd-mdb-2/gpd-mdb-2.vmx"
# vmrun stop "/mnt/md0/vms/gpd-mdb-3/gpd-mdb-3.vmx"
vmrun stop "/mnt/md0/vms/gpd-app-1/gpd-app-1.vmx"
vmrun stop "/mnt/md0/vms/gpd-app-2/gpd-app-2.vmx"
vmrun stop "/mnt/md0/vms/gpd-lb-1/gpd-lb-1.vmx"
echo "VMs Stopped"
sleep $WAIT_TIME

echo Reverting to snapshot: $SNAPSHOT ...
# vmrun -T ws revertToSnapshot /mnt/md0/vms/gpd-mdb-1/gpd-mdb-1.vmx $SNAPSHOT
# vmrun -T ws revertToSnapshot /mnt/md0/vms/gpd-mdb-2/gpd-mdb-2.vmx $SNAPSHOT
# vmrun -T ws revertToSnapshot /mnt/md0/vms/gpd-mdb-3/gpd-mdb-3.vmx $SNAPSHOT
vmrun -T ws revertToSnapshot /mnt/md0/vms/gpd-app-1/gpd-app-1.vmx $SNAPSHOT
vmrun -T ws revertToSnapshot /mnt/md0/vms/gpd-app-2/gpd-app-2.vmx $SNAPSHOT
vmrun -T ws revertToSnapshot /mnt/md0/vms/gpd-lb-1/gpd-lb-1.vmx $SNAPSHOT
echo $SNAPSHOT Snapshot restored

sleep $WAIT_TIME
echo Start VMs...
# vmrun -T ws start /mnt/md0/vms/gpd-mdb-1/gpd-mdb-1.vmx
# vmrun -T ws start /mnt/md0/vms/gpd-mdb-2/gpd-mdb-2.vmx
# vmrun -T ws start /mnt/md0/vms/gpd-mdb-3/gpd-mdb-3.vmx
vmrun -T ws start /mnt/md0/vms/gpd-app-1/gpd-app-1.vmx
vmrun -T ws start /mnt/md0/vms/gpd-app-2/gpd-app-2.vmx
vmrun -T ws start /mnt/md0/vms/gpd-lb-1/gpd-lb-1.vmx
echo VMs Started

echo Done
