{ config, pkgs, ... } : 

{
	home.packages = with pkgs; [
		neovim
		gcc # Required for tree-sitter
	];

	xdg.configFile."nvim" = {
		source = ./conf;
	};
}
