#!/bin/bash
# 10x to RPi-PXE-Server project! 
######################################################################
echo -e "\e[32minstall nfs-kernel-server\e[0m";
sudo apt-get -y install nfs-kernel-server;
######################################################################
echo -e "\e[32minstall syslinux-common for pxe\e[0m";
sudo apt-get -y install pxelinux syslinux-common
######################################################################
echo -e "\e[32minstall dnsmasq for pxe\e[0m";
sudo apt-get -y install dnsmasq
######################################################################
sudo sync
#####################################################################
DST_ROOT=/srv/tftp
DST_ISO=$DST_ROOT/iso
DST_NFS=$DST_ROOT/nfs
DST_PXE_BIOS=menu-bios
DST_PXE_EFI32=menu-efi32
DST_PXE_EFI64=menu-efi64
######################################################################
echo -e "\e[32msetup sys menu files for pxe bios\e[0m";
[ -d "$DST_ROOT/$DST_PXE_BIOS" ]              || sudo mkdir -p $DST_ROOT/$DST_PXE_BIOS;
[ -h "$DST_ROOT/$DST_PXE_BIOS/pxelinux.0" ]   || sudo ln -s /usr/lib/PXELINUX/pxelinux.0                 $DST_ROOT/$DST_PXE_BIOS/pxelinux.0;
[ -h "$DST_ROOT/$DST_PXE_BIOS/ldlinux.c32" ]  || sudo ln -s /usr/lib/syslinux/modules/bios/ldlinux.c32   $DST_ROOT/$DST_PXE_BIOS/;
[ -h "$DST_ROOT/$DST_PXE_BIOS/vesamenu.c32" ] || sudo ln -s /usr/lib/syslinux/modules/bios/vesamenu.c32  $DST_ROOT/$DST_PXE_BIOS/;
[ -h "$DST_ROOT/$DST_PXE_BIOS/libcom32.c32" ] || sudo ln -s /usr/lib/syslinux/modules/bios/libcom32.c32  $DST_ROOT/$DST_PXE_BIOS/;
[ -h "$DST_ROOT/$DST_PXE_BIOS/libutil.c32" ]  || sudo ln -s /usr/lib/syslinux/modules/bios/libutil.c32   $DST_ROOT/$DST_PXE_BIOS/;
[ -h "$DST_ROOT/$DST_PXE_BIOS/memdisk" ]      || sudo ln -s /usr/lib/syslinux/memdisk                    $DST_ROOT/$DST_PXE_BIOS/;
[ -d "$DST_ROOT/$DST_PXE_BIOS/nfs" ]          || sudo ln -s $DST_NFS                                     $DST_ROOT/$DST_PXE_BIOS/nfs;
[ -d "$DST_ROOT/$DST_PXE_BIOS/iso" ]          || sudo ln -s $DST_ISO                                     $DST_ROOT/$DST_PXE_BIOS/iso;

######################################################################
echo -e "\e[32msetup sys menu files for pxe efi32\e[0m";
[ -d "$DST_ROOT/$DST_PXE_EFI32" ]              || sudo mkdir -p $DST_ROOT/$DST_PXE_EFI32;
[ -h "$DST_ROOT/$DST_PXE_EFI32/syslinux.0" ]   || sudo ln -s /usr/lib/syslinux/modules/efi32/syslinux.c32  $DST_ROOT/$DST_PXE_EFI32/syslinux.0;
[ -h "$DST_ROOT/$DST_PXE_EFI32/ldlinux.e32" ]  || sudo ln -s /usr/lib/syslinux/modules/efi32/ldlinux.e32   $DST_ROOT/$DST_PXE_EFI32/;
[ -h "$DST_ROOT/$DST_PXE_EFI32/vesamenu.c32" ] || sudo ln -s /usr/lib/syslinux/modules/efi32/vesamenu.c32  $DST_ROOT/$DST_PXE_EFI32/;
[ -h "$DST_ROOT/$DST_PXE_EFI32/libcom32.c32" ] || sudo ln -s /usr/lib/syslinux/modules/efi32/libcom32.c32  $DST_ROOT/$DST_PXE_EFI32/;
[ -h "$DST_ROOT/$DST_PXE_EFI32/libutil.c32" ]  || sudo ln -s /usr/lib/syslinux/modules/efi32/libutil.c32   $DST_ROOT/$DST_PXE_EFI32/;
[ -d "$DST_ROOT/$DST_PXE_EFI32/nfs" ]          || sudo ln -s $DST_NFS                                      $DST_ROOT/$DST_PXE_EFI32/nfs;
[ -d "$DST_ROOT/$DST_PXE_EFI32/iso" ]          || sudo ln -s $DST_ISO                                      $DST_ROOT/$DST_PXE_EFI32/iso;

######################################################################
echo -e "\e[32msetup sys menu files for pxe efi64\e[0m";
[ -d "$DST_ROOT/$DST_PXE_EFI64" ]              || sudo mkdir -p $DST_ROOT/$DST_PXE_EFI64;
[ -h "$DST_ROOT/$DST_PXE_EFI64/syslinux.0" ]   || sudo ln -s /usr/lib/syslinux/modules/efi64/syslinux.c32  $DST_ROOT/$DST_PXE_EFI64/syslinux.0;
[ -h "$DST_ROOT/$DST_PXE_EFI64/ldlinux.e64" ]  || sudo ln -s /usr/lib/syslinux/modules/efi64/ldlinux.e64   $DST_ROOT/$DST_PXE_EFI64/;
[ -h "$DST_ROOT/$DST_PXE_EFI64/vesamenu.c32" ] || sudo ln -s /usr/lib/syslinux/modules/efi64/vesamenu.c32  $DST_ROOT/$DST_PXE_EFI64/;
[ -h "$DST_ROOT/$DST_PXE_EFI64/libcom32.c32" ] || sudo ln -s /usr/lib/syslinux/modules/efi64/libcom32.c32  $DST_ROOT/$DST_PXE_EFI64/;
[ -h "$DST_ROOT/$DST_PXE_EFI64/libutil.c32" ]  || sudo ln -s /usr/lib/syslinux/modules/efi64/libutil.c32   $DST_ROOT/$DST_PXE_EFI64/;
[ -d "$DST_ROOT/$DST_PXE_EFI64/nfs" ]          || sudo ln -s $DST_NFS                                      $DST_ROOT/$DST_PXE_EFI64/nfs;
[ -d "$DST_ROOT/$DST_PXE_EFI64/iso" ]          || sudo ln -s $DST_ISO                                      $DST_ROOT/$DST_PXE_EFI64/iso;
######################################################################
echo -e "\e[32menable port mapping and necessary services\e[0m";
sudo service nfs-common stop;
sudo service nfs-kernel-server stop;
sudo service rpcbind stop;
sudo update-rc.d rpcbind enable;
sudo update-rc.d nfs-common enable;
sudo update-rc.d nfs-kernel-server enable;
sudo update-rc.d rpcbind defaults;
sudo service rpcbind restart;
sudo service nfs-kernel-server restart;
sudo sync
#
