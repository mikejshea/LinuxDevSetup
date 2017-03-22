echo "Stopping VMs..."
vmrun stop "/mnt/md0/vms/gpd-mdb-1/gpd-mdb-1.vmx"
vmrun stop "/mnt/md0/vms/gpd-mdb-2/gpd-mdb-2.vmx"
vmrun stop "/mnt/md0/vms/gpd-mdb-3/gpd-mdb-3.vmx"
echo "VMs Stopped"
sleep 10

echo "Reverting to snapshot: Base..."
vmrun -T ws revertToSnapshot /mnt/md0/vms/gpd-mdb-1/gpd-mdb-1.vmx base
vmrun -T ws revertToSnapshot /mnt/md0/vms/gpd-mdb-2/gpd-mdb-2.vmx base
vmrun -T ws revertToSnapshot /mnt/md0/vms/gpd-mdb-1/gpd-mdb-1.vmx base
echo "Base Snapshot restored"

sleep 10
echo "Start VMs..."
vmrun -T ws start /mnt/md0/vms/gpd-mdb-1/gpd-mdb-1.vmx
vmrun -T ws start /mnt/md0/vms/gpd-mdb-2/gpd-mdb-2.vmx
vmrun -T ws start /mnt/md0/vms/gpd-mdb-3/gpd-mdb-3.vmx
echo "VMs Started"

echo "Done"
