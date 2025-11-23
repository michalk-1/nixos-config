{ pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = ["python-2.7.18.8" "electron-25.9.0"];
  };

  environment.systemPackages = with pkgs; [
    # Desktop apps
    discord
    webcord
    gparted
    vscode
    wezterm
    brave
    xfce.thunar
    xfce.xfce4-pulseaudio-plugin
    networkmanagerapplet
    blueman
    libreoffice-qt
    hunspell
    spotify

    # Development
    # nodejs
    # python
    # ruby
    # libyaml
    gcc
    # gnumake

    # CLI utils
    neovim
    neofetch
    file
    tree
    wget
    git
    fastfetch
    htop
    nix-index
    unzip
    scrot
    mediainfo
    ranger
    zip
    openssl
    swww
    wev
    bluez
    bluez-tools

    # GUI utils
    feh
    imv
    dmenu
    screenkey
    mako
    gromit-mpx
    pavucontrol

    # Wayland stuff
    xwayland
    wl-clipboard
    cliphist

    # WMs and stuff
    hyprland

    # Waybar
    waybar
    libappindicator
    libappindicator-gtk3
    libdbusmenu-gtk3
    spdlog

    # Sound
    pipewire
    pulseaudio
    pamixer
    playerctl

    # Screenshotting
    grim
    grimblast
    slurp
    flameshot
    swappy

    # Other
    home-manager
    spice-vdagent
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct

    # Screensharing
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
    wireplumber
  ];
  
  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    twemoji-color-font
    font-awesome
    powerline-fonts
    powerline-symbols
    pkgs.nerd-fonts.symbols-only
  ];
}
