#!/usr/bin/env bash

#PARTITIONING
nix --experimental-features 'nix-command flakes' run github:nix-community/disko -- --mode disko ./disko-config.nix

#HARDWARE CONFIGURATION
nix-generate-config --root /mnt
cp /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/hardware-configuration.nix

#INSTALLATION
nixos-install --flake .#nixos

#COPY CONFIGURATION
mkdir /mnt/home/domnuraul/nix 
cp ./* /mnt/home/domnuraul/nix