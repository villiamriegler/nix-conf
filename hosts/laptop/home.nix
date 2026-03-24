{ self, inputs, ... }:

{
  flake.homeModules.laptop =
    { config, pkgs, lib, ... }:
    {
      imports = [
	    self.homeModules.base
	    self.homeModules.kitty
		self.homeModules.niri
		self.homeModules.nvim
		self.homeModules.quickshell
		self.homeModules.zsh
      ];

      internal-modules.niri = {
        monitors = ''
          output "eDP-1" {
          	mode "1920x1200@59.88"
          	position x=0 y=0
          	focus-at-startup
          }
        '';

        keyboard-layouts = [ "se" ];
      };

      home.stateVersion = "25.11";

      programs.home-manager.enable = true;
    };
}
