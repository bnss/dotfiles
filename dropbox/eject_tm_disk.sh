#!/bin/bash

# if first argument disk#, use disk#
# else, use disk3

printf "\n===================================="
printf "\nInitializing eject disk procedure...\n"

set -e
set -u
set -o pipefail

TM_UTIL=/usr/bin/tmutil
DISK_UTIL=/usr/sbin/diskutil
TMVOLUME=/Volumes/LaCie

# TM_DISK=disk$(diskutil list | grep "Apple_HFS LaCie" | sed s'/\(^.*\)\(.$\)/\2/')
TM_DISK=disk3

if [ $# -gt 0 ] && [ "$1" != "" ]; then
  if [[ "$1" == "-h"  ]]; then
    printf "\nDisk list:\n\n"
    ${DISK_UTIL} list
    printf "Enter disk number (empty to use disk3)\n\n"
    exit 1
  else
    TM_DISK="disk$1"
  fi
fi

touch ~/Downloads/ejectDisk.txt

# Stopping Time Machine
printf "\n[$(date)] Stopping timemachine..."
${TM_UTIL} stopbackup >> ~/Downloads/ejectDisk.txt

# Unmount the disk
printf "\n[$(date)] Unmounting volumes of disk3...\n"
# sudo umount -f /dev/${TM_DISK}
sudo ${DISK_UTIL} unmountDisk ${TM_DISK} >> ~/Downloads/ejectDisk.txt
if [ $? -ne 0 ]; then
  printf "\n[$(date)] Forcing unmount...\n"
  sudo ${DISK_UTIL} unmountDisk force ${TM_DISK} >> ~/Downloads/ejectDisk.txt
fi

printf "\n[$(date)] Unmounting volumes of disk2...\n"
sudo ${DISK_UTIL} unmountDisk disk2 >> ~/Downloads/ejectDisk.txt

# Making sure it is unmounted
# test -d "$TMVOLUME"
# while [ $? = 0 ]; do
#   sleep 300
#   sudo ${DISK_UTIL} unmountDisk ${TM_DISK}
#   test -d "$TMVOLUME"
# done

# Ejecting the disk
printf "\n[$(date)] Ejecting disk..."
${DISK_UTIL} eject ${TM_DISK} >> ~/Downloads/ejectDisk.txt

printf "[$(date)] Done.\n"
