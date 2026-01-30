{ pkgs, ... }:
{
  # Packages that will be installed in both NixOS and darwin
  environment.systemPackages = with pkgs; [
    ffmpeg
    fnm
    hatch
    nodejs_22
    neovim
    poetry
    prettierd
    silver-searcher
    starship
    tree
    uv
  ];
}
