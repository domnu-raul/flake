# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.settings.allowed-users = ["domnuraul"];

    imports = [ 
        ./hardware-configuration.nix
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "nixos"; # Define your hostname.
    networking.networkmanager.enable = true;
    # networking.wireless.enable = true;
    # networking.wireless.networks."DIGI-RJur".psk = "gxzv9d6m";


    time.timeZone = "Europe/Bucharest";
    i18n.defaultLocale = "en_US.UTF-8";

    services.xserver = {
        xkb.layout = "us";
        xkb.variant = "";

        enable = true;
        displayManager = {
            sddm = {
                enable = true;
                # theme = "rose-pine";
            };
            defaultSession = "none+bspwm";
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

    programs.git.enable = true;

    programs.zsh.enable=true;

    programs.neovim = {
        enable = true;
        vimAlias = true;
        viAlias = true;
        defaultEditor = true;
    };

    virtualisation.docker.enable = true;
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = [ "domnuraul" ];

    environment.systemPackages = with pkgs; [
        fzf
        stow
        wget
        unzip
        xclip 
        pamixer
        pulseaudio
        pavucontrol
        corefonts
        xidlehook
        flatpak
        htop

        ffmpeg-full
        google-chrome
        vlc

        # SDDM theme
        libsForQt5.qt5.qtgraphicaleffects
        (callPackage ./sddm-rose-pine.nix {})

        gcc
        clang
        llvm
        rustup
        nodejs_22
        python3
        lua
        stylua
        poetry
        jdk
    ];

    system.stateVersion = "24.05"; # Did you read the comment?

    # nixpkgs.config = {
    #     allowUnfree = true; 
    #     packageOverrides = pkgs: {
    #         intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
    #     };
    # };


    # services.xserver.videoDrivers = [ "nouveau" "intel" "modesetting"];
    # services.xserver.videoDrivers = [ "nvidia"];
    # hardware.nvidia = {
    #     open = false;
    #     nvidiaSettings = true;
    #     package = config.boot.kernelPackages.nvidiaPackages.stable;
    #     modesetting.enable = true;
    #     forceFullCompositionPipeline = true;
    #     prime = {
    #         sync.enable = true; # always only run on nvidia
    #         # offload.enable = true;
    #
    #         intelBusId = "PCI:0:2:0";
    #         nvidiaBusId = "PCI:1:0:0";
    #     };
    # };
    #
    # hardware.graphics = {
    #     enable = true;
    #     extraPackages = with pkgs; [
    #         intel-media-driver # LIBVA_DRIVER_NAME=iHD
    #         intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
    #         libvdpau-va-gl
    #     ];
    # };

    users.defaultUserShell = pkgs.zsh;
    zramSwap.enable = true;
}
