#!/bin/bash
# 10x to RPi-PXE-Server project! 
######################################################################
echo -e "\e[32minstall nfs-kernel-server\e[0m";
sudo apt-get -y install nfs-kernel-server;
######################################################################
echo -e "\e[32minstall dhcpcd5\e[0m";
sudo apt-get -y install dhcpcd5
[ -e /etc/dhcpcd.conf ] && mv /etc/dhcpcd.conf /etc/dhcpcd.conf.orig
sudo cat <<EOT > /etc/dhcpcd.conf
hostname
clientid
persistent
option rapid_commit
option domain_name_servers, domain_name, domain_search, host_name
option classless_static_routes
option ntp_servers
require dhcp_server_identifier
slaac private
nohook lookup-hostname
########################################
interface eth0
static ip_address=10.9.8.1/24
EOT
######################################################################
echo -e "\e[32minstall syslinux-common for pxe\e[0m";
sudo apt-get -y install pxelinux syslinux-common
######################################################################
echo -e "\e[32minstall dnsmasq for pxe\e[0m";
sudo apt-get -y install dnsmasq
######################################################################
sudo cat <<EOT > /etc/dnsmasq.d/pxeboot
########################################
#/etc/dnsmasq.d/pxeboot

log-dhcp
log-queries

# DNS (enabled)
port=53
dns-loop-detect

# TFTP (enabled)
enable-tftp
tftp-root=/srv/tftp/
tftp-lowercase

# PXE (enabled)
pxe-service=x86PC, "PXE Boot Menu (BIOS 00:00)", menu-bios/pxelinux
pxe-service=6, "PXE Boot Menu (UEFI 00:06)", menu-efi32/syslinux
pxe-service=x86-64_EFI, "PXE Boot Menu (UEFI 00:07)", menu-efi64/syslinux
pxe-service=9, "PXE Boot Menu (UEFI 00:09)", menu-efi64/syslinux
#dhcp-boot=menu-bios/pxelinux.0
dhcp-match=set:x86_BIOS, option:client-arch, 0
dhcp-match=set:x86_UEFI, option:client-arch, 6
dhcp-match=set:x64_UEFI, option:client-arch, 7
dhcp-match=set:x64_UEFI, option:client-arch, 9
dhcp-boot=tag:x86_BIOS, menu-bios/pxelinux.0
dhcp-boot=tag:x86_UEFI, menu-efi32/syslinux.0
dhcp-boot=tag:x64_UEFI, menu-efi64/syslinux.0

#dhcp-range=169.254.196. 192.168.1.0, proxy

# do not give IPs that are in pool of DSL routers DHCP
dhcp-range= 10.9.8.99,10.9.8.180, 1h

# do not handle MACs that will get IP by DSL routers DHCP
#dhcp-host=11:22:33:44:55:66, ignore # comment
EOT
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
######################################################################
echo -e "\e[32mconfigure /etc/exports\e[0m";
[ -e /etc/exports ] && mv /etc/exports /etc/exports.orig
sudo cat <<EOT > /etc/exports
/srv/tftp/nfs/perfecto  10.9.8.0/24(ro,no_subtree_check,async,root_squash)
/srv/tftp/iso 10.9.8.0/24(ro,sync,no_root_squash,no_subtree_check)
/srv/work 10.9.8.0/24(rw,sync,no_root_squash,no_subtree_check)
/srv/stats 10.9.8.0/24(rw,fsid=1,sync,no_subtree_check)
EOT
######################################################################
sudo update-rc.d rpcbind enable;
sudo update-rc.d nfs-common enable;
sudo update-rc.d nfs-kernel-server enable;
sudo update-rc.d rpcbind defaults;
sudo service rpcbind restart;
sudo service nfs-kernel-server restart;
sudo exportfs -a
sudo sync
#
