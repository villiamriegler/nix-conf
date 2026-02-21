{ config, pkgs, ... } : 

{
	imports = [
		./modules/home
	];

	home.username = "villiamr";
	home.homeDirectory = "/home/villiamr";

	home.packages = with pkgs; [
		git
		kitty
		alacritty
		fuzzel
		mako
		waybar
		swaybg
		swayidle
		hyprlock
		lazygit
	];

	services.polkit-gnome.enable = true;

	programs.git = {
		enable = true;
		settings = {
			user.name = "villiamriegler";
			user.email = "ville@riegler.se";
		};
	};

	programs.kitty = {
		enable = true;
		font.name = "JetBrainsMono NF";
		font.package = pkgs.nerd-fonts.jetbrains-mono;
	};


	home.stateVersion = "25.11";

	programs.home-manager.enable = true;
}
