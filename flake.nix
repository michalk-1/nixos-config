{
  description = "NixOS system configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # https://nix.catppuccin.com/getting-started/flakes/
    catppuccin.url = "github:catppuccin/nix/release-25.05";
  };

  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    catppuccin,
    ...
  }@inputs : {
    # NixOS PC
    nixosConfigurations.BD-1 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
        ./nixos/configuration.nix
        catppuccin.nixosModules.catppuccin
      ];
    };
    homeConfigurations.grabowskip = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        ./home-manager/home-linux.nix
        catppuccin.homeModules.catppuccin
      ];
    };

    # Work MacBook
    darwinConfigurations.grabowskip-work = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./darwin/work/configuration.nix
      ];
    };
    homeConfigurations."patryk.grabowski@iqvia.com" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.aarch64-darwin;
      modules = [
        ./home-manager/home-darwin.nix
        catppuccin.homeModules.catppuccin
      ];
    };
  };
}
