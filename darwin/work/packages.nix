{ pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = ["python-2.7.18.8" "electron-25.9.0"];
  };

  environment.systemPackages = with pkgs; [
    # Desktop apps
    vscode
    wezterm
    brave
    spotify

    # Development
    # nodejs
    # python
    # ruby
    # libyaml
    # gcc
    # gnumake

    # CLI utils
    neovim
    file
    tree
    wget
    git
    fastfetch
    htop
    nix-index
    unzip
    mediainfo
    ranger
    zip
    openssl
    chafa
    nil
    nixd

    # Other
    home-manager
  ];
}
