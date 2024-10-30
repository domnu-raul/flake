#!/usr/bin/env bash

#PARTITIONING
nix --experimental-features 'nix-command flakes' run github:nix-community/disko -- --mode disko ./disko.nix

#HARDWARE CONFIGURATION
nixos-generate-config --root /mnt
cp /mnt/etc/nixos/hardware-configuration.nix .

#INSTALLATION
TMPDIR=/mnt/Flake/tmp nixos-install --flake .#nixos

#COPY CONFIGURATION
mkdir /mnt/home/domnuraul/nix 
cp ./* /mnt/home/domnuraul/nix
