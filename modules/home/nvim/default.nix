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
	  nodePackages.nodejs
	  pyright
	  python314Packages.python-lsp-server
    ];
  };

  xdg.configFile."nvim" = {
    source = ./conf;
  };
}
