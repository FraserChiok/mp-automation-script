#!/bin/bash

# Define variables
ACTUALDIR="/var/log"
LV_NAME="$(echo "$ACTUALDIR" | sed 's/\//-/g' | sed 's/^-\(.*\)$/\1/')_lv"
BACKUPDIR="/backup$ACTUALDIR"
VG="vg0"
DEVICE="/dev/nvme0n1"
LV_SIZE="2G"  # Default size, can be adjusted as needed

# Function to check if the volume group exists, if not create it
create_vg_if_not_exists() {
    sudo vgdisplay "$VG" > /dev/null 2>&1 || sudo vgcreate "$VG" "$DEVICE"
}

# Function to create the logical volume
create_logical_volume() {
    sudo lvcreate -n "$LV_NAME" -L "$LV_SIZE" "$VG"
}

# Function to create ext4 filesystem
create_ext4_filesystem() {
    sudo mkfs.ext4 "/dev/$VG/$LV_NAME"
}

# Function to mount logical volume to directory
mount_logical_volume() {
    sudo mount "/dev/$VG/$LV_NAME" "$ACTUALDIR"
}

# Function to add entry to /etc/fstab
add_to_fstab() {
    echo "/dev/$VG/$LV_NAME $ACTUALDIR ext4 defaults 0 2" | sudo tee -a /etc/fstab
}

# Main script
create_vg_if_not_exists
sudo mkdir -p "$BACKUPDIR"
sudo rsync -axv "$ACTUALDIR/" "$BACKUPDIR"
create_logical_volume
create_ext4_filesystem
mount_logical_volume
add_to_fstab

# Reboot system
sudo reboot
