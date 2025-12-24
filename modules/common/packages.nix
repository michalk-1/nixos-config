{ pkgs, ... }:
{
  # Packages that will be installed in both NixOS and darwin
  environment.systemPackages = with pkgs; [
    ffmpeg
    fnm
    nodejs_22
    nvim
    poetry
    prettierd
    silver-searcher
    starship
    tree
    uv
  ];
}
