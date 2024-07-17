{config, pkgs, spicetify-nix, ... }:
let
    spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
in
{
    home.username = "domnuraul";
    home.homeDirectory = "/home/domnuraul";
    home.stateVersion = "24.05"; # Do not change
    nixpkgs.config.allowUnfree = true;
    home.pointerCursor = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
      size = 24;
      gtk.enable = true;
      x11 = {
        enable = true;
        defaultCursor = true;
      };
    };

    fonts.fontconfig.enable=true;

    imports = [ spicetify-nix.homeManagerModule ];
    programs.spicetify =
    # let officialThemesOLD = pkgs.fetchgit {
    #     url = "https://github.com/spicetify/spicetify-themes";
    #     rev = "c2751b48ff9693867193fe65695a585e3c2e2133";
    #     sha256 = "0rbqaxvyfz2vvv3iqik5rpsa3aics5a7232167rmyvv54m475agk";
    # };
    in
    {
        enable = true;

        # Cool terminal looking theme
        theme = spicePkgs.themes.text;
        colorScheme = "RosePineMoon";

        # theme = spicePkgs.themes.Ziro;
        # colorScheme = "rose-pine-moon";

        enabledExtensions = with spicePkgs.extensions; [
            hidePodcasts
            adblock
            trashbin
            bookmark
        ];

        enabledCustomApps = with spicePkgs.apps; [
            lyrics-plus
            new-releases
        ];

    };

    programs.git.enable = true;

    programs.neovim = {
        enable = true;
        vimAlias = true;
        viAlias = true;
        defaultEditor = true;
    };



    home.packages = [
        pkgs.starship
        pkgs.zoxide
        pkgs.eza
        pkgs.zellij
        pkgs.kitty
        pkgs.vscode
        pkgs.qbittorrent
        pkgs.firefox

        pkgs.gimp
        pkgs.flameshot
        pkgs.neofetch
        pkgs.cmatrix

        pkgs.rofi
        pkgs.picom
        pkgs.nitrogen
        # pkgs.lxappearance
        pkgs.i3lock-color

        (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "DejaVuSansMono" "FiraMono" "UbuntuMono"]; })
        pkgs.fira-sans

        pkgs.pciutils
        pkgs.gh
    ];

# Home Manager is pretty good at managing dotfiles. The primary way to manage
# plain files is through 'home.file'.
    home.file = {
# # Building this configuration will create a copy of 'dotfiles/screenrc' in
# # the Nix store. Activating the configuration will then make '~/.screenrc' a
# # symlink to the Nix store copy.
# ".screenrc".source = dotfiles/screenrc;

# # You can also set the file content immediately.
# ".gradle/gradle.properties".text = ''
#   org.gradle.console=verbose
#   org.gradle.daemon.idletimeout=3600000
# '';
    };

# Home Manager can also manage your environment variables through
# 'home.sessionVariables'. These will be explicitly sourced when using a
# shell provided by Home Manager. If you don't want to manage your shell
# through Home Manager then you have to manually source 'hm-session-vars.sh'
# located at either
#
#  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
#
# or
#
#  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
#
# or
#
#  /etc/profiles/per-user/domnuraul/etc/profile.d/hm-session-vars.sh

    home.sessionVariables = {
        EDITOR = "nvim";
    };

# Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
