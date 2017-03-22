mkdir /mnt/dvd;mount -o loop /dev/sr0 /mnt/dvd

mkdir -p ~/kickstart_build
cp -R /mnt/dvd/isolinux ~/kickstart_build/isolinux

mkdir -p ~/kickstart_build/utils

cp /mnt/dvd/.discinfo ~/kickstart_build/isolinux/.discinfo
cp -R /mnt/dvd/images/ ~/kickstart_build/isolinux/images/
cp -R /mnt/dvd/LiveOS/ ~/kickstart_build/isolinux/LiveOS/
cp -R /mnt/dvd/Packages/ ~/kickstart_build/isolinux/Packages/

\cp -rf comps.xml ~/kickstart_build/isolinux/comps.xml
\cp -rf ks.cfg ~/kickstart_build/isolinux/ks.cfg
\cp -rf isolinux.cfg ~/kickstart_build/isolinux/isolinux.cfg

yum -y install createrepo
cd ~/kickstart_build/isolinux
createrepo -g ~/kickstart_build/isolinux/comps.xml .

cd ~/kickstart_build
mkisofs -o ~/centos7.iso -b isolinux.bin -c boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -R -J -v -V "CentOS 7 x86_64" -T isolinux/. .
