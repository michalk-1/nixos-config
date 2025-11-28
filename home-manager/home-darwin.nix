{ pkgs, ...}:
{

  catppuccin = {
    enable = true;
    accent = "peach";
    flavor = "mocha";

    nvim = {
      enable = false;
    };
  };

  imports = [
    # ./import-home-dir.nix
    ./modules/common/bundle.nix
    ./modules/darwin/bundle.nix
  ];

  home = {
    username = "patryk.grabowski@iqvia.com";
    homeDirectory = "/Users/patryk.grabowski@iqvia.com";
    stateVersion = "25.05";

    sessionVariables = {
      # TERMINAL = "${pkgs.wezterm}/bin/wezterm";
    };
  };
}
