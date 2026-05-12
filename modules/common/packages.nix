{ pkgs, ... }:
{
  # Packages that will be installed in both NixOS and darwin
  environment.systemPackages = with pkgs; [
    codex
    ffmpeg
    fnm
    hatch
    neovim
    nodejs_22
    poetry
    prettierd
    silver-searcher
    starship
    telegram-desktop
    tree
    uv
  ];
}
