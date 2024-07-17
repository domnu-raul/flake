{
    description = "Config flake";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        spicetify-nix.url = "github:the-argus/spicetify-nix";
    };

    outputs = {
        self,
        nixpkgs,
        home-manager,
        spicetify-nix,
        ...
    }: 
    let
        lib = nixpkgs.lib;
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
    in {
        nixosConfigurations.nixos = lib.nixosSystem {
            inherit system;
            modules = [
                ./configuration.nix 
                home-manager.nixosModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;

                    home-manager.users.domnuraul = import ./home.nix;
                    home-manager.extraSpecialArgs = {inherit spicetify-nix;};
                }
            ];
        };
    };
}
