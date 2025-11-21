{
  description = "NixOS system configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

  };

  outputs = {
    self,
    nixpkgs,
    ...
  }@inputs :
    let 
      system = "x86_64-linux";
    in{
    nixosConfigurations.BD-1 = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [ 
        ./nixos/configuration.nix
      ];
    };

  };


}
