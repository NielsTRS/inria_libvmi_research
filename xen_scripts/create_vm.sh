export vm_name='basevm'
export nic='enp24s0f0'
export path='VMs'
export disk_size=30720
export mac='00:16:3E:84:00:02'
export base_path="/home/nterese"

mkdir $base_path/$path

rm $base_path/$path/"${vm_name}.*"

# brctl addbr xenbr0
# brctl addif xenbr0 $nic
# dhclient xenbr0
# ifconfig $nic 0.0.0.0

cd $base_path/$path

dd if=/dev/zero of=$base_path/$path/"${vm_name}.img" bs=1M count=$disk_size

wget http://archive.ubuntu.com/ubuntu/dists/bionic-updates/main/installer-amd64/current/images/netboot/xen/initrd.gz
wget http://archive.ubuntu.com/ubuntu/dists/bionic-updates/main/installer-amd64/current/images/netboot/xen/vmlinuz

echo "
kernel=\"$base_path/$path/vmlinuz\"
ramdisk=\"$base_path/$path/initrd.gz\"
memory=\"2048\"
vcpus=1
name=\"$vm_name\"
disk=[ 'file: $base_path/$path/$vm_name.img,ioemu:hda,w' ]
vif=[ 'bridge=xenbr0,mac=$mac' ]
">"${vm_name}.cfg"

xl create -c "${vm_name}.cfg"

echo "
memory="2048"
vcpus=1
name=\"$vm_name\"
disk=[ 'file: $base_path/$path/$vm_name.img,ioemu:hda,w' ]
vif=[ 'bridge=xenbr0,mac=$mac' ]
bootloader=\"/usr/local/bin/pygrub\"
">"${vm_name}.cfg"
