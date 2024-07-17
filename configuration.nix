# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.settings.allowed-users = ["domnuraul"];
    nixpkgs.config.allowUnfree = true; 

    imports = [ 
        ./hardware-configuration.nix
    ];

    boot.loader.systemd-boot.enable = true;

    networking.hostName = "nixos"; 
    networking.networkmanager.enable = true;
    # networking.wireless.enable = true;
    # networking.wireless.networks."SSID".psk = "PASSWORD";


    time.timeZone = "Europe/Bucharest";
    i18n.defaultLocale = "en_US.UTF-8";

    services.xserver = {
        xkb.layout = "us";
        xkb.variant = "";

        enable = true;
        displayManager = {
            sddm = {
                enable = true;
                theme = "rose-pine";
            };
        };

        windowManager.awesome.enable = true;
    };

    services.printing.enable = true;
    # sound.enable = false;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
    };

# Enable touchpad support (enabled default in most desktopManager).
    services.xserver.libinput.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.domnuraul = {
        isNormalUser = true;
        description = "domnuraul";
        extraGroups = [ "audio" "networkmanager" "wheel" ];
    };


    virtualisation.docker.enable = true;
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = [ "domnuraul" ];

    environment.systemPackages = with pkgs; [
        fzf
        wget
        unzip
        xclip 
        pamixer
        pulseaudio
        pavucontrol
        corefonts
        xidlehook
        htop

        ffmpeg-full
        vlc

        # SDDM theme
        libsForQt5.qt5.qtgraphicaleffects
        (callPackage ./sddm-rose-pine.nix {})

        gcc
        clang
        llvm
        rustup
        python3
        lua
    ];

    system.stateVersion = "24.05"; # Did you read the comment?

    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;
    # zramSwap.enable = true;
}
