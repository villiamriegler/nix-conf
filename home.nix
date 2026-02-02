{ config, pkgs, ... } : 

{
	home.username = "villiamr";
	home.homeDirectory = "/home/villiamr";

	home.packages = with pkgs; [
		neovim
		git
		alacritty
		fuzzel
		mako
		waybar
		swaybg
		swayidle
	];

	services.polkit-gnome.enable = true;

	programs.git = {
		enable = true;
		settings = {
			user.name = "villiamriegler";
			user.email = "ville@riegler.se";
		};
	};

	home.stateVersion = "25.11";

	programs.home-manager.enable = true;
}
