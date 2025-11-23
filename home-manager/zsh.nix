{ config, ... }:

{

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting = { 
      enable = true;
      highlighters = ["main" "brackets" "pattern"];
      styles = {
        "single-hyphen-option" = "fg=magenta,bold";
        "double-hyphen-option" = "fg=yellow";
      };
      
    };

    localVariables = {
      ZSH_TMUX_AUTOSTART = true;
    };   
 
    shellAliases =
      let
        flakeDir = "~/nixos-config";
        configuration = "BD-1";
      in {
      rb = "sudo nixos-rebuild switch --flake ${flakeDir}#${configuration}";
      upd = "nix flake update ${flakeDir}";
      upg = "sudo nixos-rebuild switch --upgrade --flake ${flakeDir}";

      hms = "home-manager switch --flake ${flakeDir}";

      conf = "nvim ${flakeDir}/nixos/configuration.nix";
      pkgs = "nvim ${flakeDir}/nixos/packages.nix";

      ll = "ls -l";
      vim = "nvim";
      v = "nvim";
      se = "sudoedit";
      ff = "fastfetch";
    };

    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";

    # Plugin manager
    antidote = {
      enable = true;
      plugins = [
        # Completions
        "mattmc3/ez-compinit"
        "zsh-users/zsh-completions"
        "zsh-users/zsh-autosuggestions"
        "Aloxaf/fzf-tab"
        "zdharma-continuum/fast-syntax-highlighting"
        "so-fancy/diff-so-fancy"

        # OMZ deps
        "getantidote/use-omz"
        "ohmyzsh/ohmyzsh path:plugins/git"
        "ohmyzsh/ohmyzsh path:plugins/nvm"
        "ohmyzsh/ohmyzsh path:plugins/extract"
        "ohmyzsh/ohmyzsh path:plugins/command-not-found"
        "ohmyzsh/ohmyzsh path:plugins/tmux"
        "ohmyzsh/ohmyzsh path:plugins/sudo"
      ];
      useFriendlyNames = true;
    };
  };

  programs.fzf = {
    enable = true;
  };

  programs.ripgrep = {
    enable = true;
  };
}
