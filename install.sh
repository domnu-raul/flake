#!/usr/bin/env bash

# disko partitions
nix --experimental-features 'nix-command flakes' run github:nix-community/disko -- --mode disko ./disko-config.nix
nix-generate-config --root /mnt
cp /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/hardware-configuration.nix
nixos-install --flake .#nixos
