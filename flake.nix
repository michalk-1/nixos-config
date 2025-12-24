{
  description = "NixOS system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS profiles to optimize settings for different hardware
    hardware.url = "github:nixos/nixos-hardware";

    # https://nix.catppuccin.com/getting-started/flakes/
    catppuccin.url = "github:catppuccin/nix/release-25.05";
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      catppuccin,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      forAllSystems = f: nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-darwin" ] f;

      # User configuration
      users = {
        grabowskip = {
          avatar = ./files/avatar/face;
          email = "grabowskip@icloud.com";
          fullName = "Patryk Grabowski";
          name = "grabowskip";
        };
        "michalkowalik" = {
          inherit (users.grabowskip)
            avatar
            ;
          email = "mich.kowalik@gmail.com";
	  fullName = "Michał Kowalik";
          name = "michalkowalik";
        };
      };

      # Function for NixOS system configuration
      mkNixosConfiguration =
        hostname: username:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs hostname;
            userConfig = users.${username};
            nixosModules = "${self}/modules/nixos";
          };
          modules = [
            catppuccin.nixosModules.catppuccin
            ./hosts/${hostname}
          ];
        };
      # Function for nix-darwin system configuration
      mkDarwinConfiguration =
        hostname: username:
        nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = {
            inherit inputs outputs hostname;
            userConfig = users.${username};
            darwinModules = "${self}/modules/darwin";
          };
          modules = [
            ./hosts/${hostname}
          ];
        };

      # Function for Home Manager configuration (linux)
      mkHomeConfiguration =
        system: username: hostname:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { inherit system; };
          extraSpecialArgs = {
            inherit inputs outputs hostname;
            userConfig = users.${username};
            nhModules = "${self}/modules/home-manager";
          };
          modules = [
            ./home/${username}/${hostname}
            catppuccin.homeModules.catppuccin
          ];
        };
    in
    {
      packages = forAllSystems (system:
	let
	  pkgs = import nixpkgs { inherit system; };
	in
	{
	  default = pkgs.hello;
	}
      );

      nixosConfigurations = {
        skocznia = mkNixosConfiguration "skocznia" "grabowskip";
      };

      darwinConfigurations = {
        air-kw = mkDarwinConfiguration "air-kw" "michalkowalik";
      };

      homeConfigurations = {
        "grabowskip@skocznia" = mkHomeConfiguration "x86_64-linux" "grabowskip" "skocznia";
        "michalkowalik@air-kw" =
          mkDarwinHomeConfiguration "aarch64-darwin" "michalkowalik"
            "air-kw";
      };

      overlays = import ./overlays { inherit inputs; };

      devShells = forAllSystems (system:
	let
	  pkgs = import nixpkgs { inherit system; };
	in
	{
	  default = pkgs.mkShell {
	    buildInputs = [
	      pkgs.git
	      pkgs.nodejs
	    ];
	  };
	}
      );

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
}
