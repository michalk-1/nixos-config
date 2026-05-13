{ pkgs, ... }:
{
  # Packages that will be installed in both NixOS and darwin
  environment.systemPackages = with pkgs; [
    codex
    ffmpeg
    fnm
    git
    hatch
    neovim
    nodejs_22
    poetry
    prettierd
    signal-cli
    silver-searcher
    soco-cli
    starship
    telegram-desktop
    tldr
    tree
    uv
  ];
}
