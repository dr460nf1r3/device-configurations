#!/usr/bin/env sh
set -o errexit

# Create EFI
mkfs.vfat -F32 /dev/sda1

# Create pool
zpool create -f zroot /dev/sda2
zpool set autotrim=on zroot
zfs set compression=zstd zroot
zfs set mountpoint=none zroot
zfs create -o refreservation=10G -o mountpoint=none zroot/reserved

# System volumes
zfs create -o mountpoint=none zroot/data
zfs create -o mountpoint=none zroot/ROOT
zfs create -o mountpoint=legacy zroot/ROOT/empty
zfs create -o mountpoint=legacy zroot/ROOT/nix
zfs create -o mountpoint=legacy zroot/ROOT/residues
zfs create -o mountpoint=legacy zroot/data/persistent
zfs snapshot zroot/ROOT/empty@start

# Encrypted volumes
zfs create -o encryption=on -o keyformat=passphrase \
	-o mountpoint=/home/nico/.encrypted zroot/data/encrypted

# Mount & Permissions
mount -t zfs zroot/ROOT/empty /mnt
mkdir -p /mnt/nix /mnt/var/persistent \
	/mnt/var/residues /mnt/boot
mount -t zfs zroot/ROOT/nix /mnt/nix
chown -R 1000:100 /mnt/home/nico
chmod 0700 /mnt/home/nico
mount -t zfs zroot/data/persistent /mnt/var/persistent
mount -t zfs zroot/ROOT/residues /mnt/var/residues
mount /dev/sda1 /mnt/boot

# Podman
zfs create -o mountpoint=none -o canmount=on zroot/containers

echo "Finished."
