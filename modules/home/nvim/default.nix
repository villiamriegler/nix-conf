{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    extraPackages = with pkgs; [
      unzip
      kdePackages.qtdeclarative
      lua-language-server
      gnumake
      gcc
      nixd
      nil
      ripgrep
      fd
      luarocks
      python3
      tree-sitter
    ];
  };

  xdg.configFile."nvim" = {
    source = ./conf;
  };
}
