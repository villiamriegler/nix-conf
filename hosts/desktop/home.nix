{ self, inputs, ... }:

{
  flake.homeModules.desktop =
    { config, pkgs, lib, ... }:
    {
      imports = [
	    self.homeModules.base
	    self.homeModules.kitty
		self.homeModules.nvim
		self.homeModules.quickshell
		self.homeModules.zsh
      ];


      #internal-modules.niri.monitors = ''
      #  output "PNP(BNQ) BenQ SW271 P4J00325SL0" {
      #  	mode "3840x2160@60.001"
      #  	scale 1.5
      #  	position x=0 y=0
      #  	focus-at-startup
      #  }

      #  output "Acer Technologies Acer XF240H 0x6390D9CE" {
      #  	mode "1920x1080@119.982"
      #  	scale 1
      #  	position x=2560 y=180
      #  }
      #'';

      #internal-modules.niri.keyboard-layouts = [
      #  "swerty"
      #  "us"
      #];

      home.packages = with pkgs; [
        prismlauncher
        obs-studio
        obsidian
        spotify
      ];

      home.stateVersion = "25.11";

      programs.home-manager.enable = true;
    };
}
