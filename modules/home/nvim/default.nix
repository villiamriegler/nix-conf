{ config, pkgs, ... } : 

{
	programs.neovim = {
	  enable = true;

	  extraPackages = with pkgs; [
	    unzip
	    kdePackages.qtdeclarative
	    lua-language-server
	    gnumake
	    gcc 
	    ripgrep
	    fd
	  ];
	};

	xdg.configFile."nvim" = {
		source = ./conf;
	};
}
