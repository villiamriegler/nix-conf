{ self, inputs, ... }:

{
  flake.homeModules.laptop =
    { config, pkgs, lib, ... }:
    {
      imports = [
	    self.homeModules.base
	    self.homeModules.kitty
		self.homeModules.nvim
		self.homeModules.quickshell
		self.homeModules.zsh
      ];

      home.stateVersion = "25.11";

      programs.home-manager.enable = true;
    };
}
