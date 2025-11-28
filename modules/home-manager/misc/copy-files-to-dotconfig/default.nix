{ config, ... }:
{
  home.file = {
    wallpapers = {
      source = config.lib.file.mkOutOfStoreSymlink ../../../../files/wallpapers;
      target = ".config/wallpapers";
      recursive = true;
    };

    fsh = {
      source = config.lib.file.mkOutOfStoreSymlink ../../../../files/fsh;
      target = ".config/fsh";
      recursive = true;
    };
  };
}
