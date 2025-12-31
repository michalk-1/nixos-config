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
        michalkowalik = {
          avatar = ./files/avatar/face;
          email = "mich.kowalik@gmail.com";
          fullName = "Michał Kowalik";
          name = "michalkowalik";
        };
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
            nhModules = "${self}/modules/home-manager";
          };

          modules = [
            ./hosts/${hostname}

            # Enable Home Manager as a nix-darwin module
            home-manager.darwinModules.home-manager

            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.extraSpecialArgs = {
                inherit inputs outputs hostname;
                userConfig = users.${username};
                nhModules = "${self}/modules/home-manager";
              };

              home-manager.users.${username} = {
                imports = [
                  ./home/${username}/${hostname}
                  catppuccin.homeModules.catppuccin
                ];
              };
            }
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

      darwinConfigurations = {
        air-kw = mkDarwinConfiguration "air-kw" "michalkowalik";
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

              # Add Python + pytest
              (pkgs.python3.withPackages (ps: [
                ps.pytest
                ps.mypy
                ps.more-itertools
              ]))
            ];
          };
        }
      );

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
}
