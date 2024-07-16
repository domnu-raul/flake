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
            modules = [ ./configuration.nix ];
        };
        homeConfigurations.domnuraul = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = {inherit spicetify-nix;};
            modules = [ ./home.nix ];
        };
    };
}
