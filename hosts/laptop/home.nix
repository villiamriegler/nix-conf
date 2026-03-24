{ self, inputs, ... }:

{
  flake.homeModules.laptop =
    { config, pkgs, lib, ... }:
    {
      imports = [
	    self.homeModules.kitty
		self.homeModules.niri
		self.homeModules.nvim
		self.homeModules.quickshell
		self.homeModules.zsh
      ];

      home.username = "villiamr";
      home.homeDirectory = "/home/villiamr";

      programs.direnv = {
        enable = true;

        enableZshIntegration = true;
        nix-direnv.enable = true;
      };

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

      home.packages = with pkgs; [
        git
        kitty
        fuzzel
        mako
        swaybg
        swayidle
        hyprlock
        lazygit
        neofetch
        fastfetch
        discord
        tree
        firefox
        obs-studio
        obsidian
      ];

      home.pointerCursor = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
        size = 24;
        gtk.enable = true;
        x11.enable = true;
      };

      home.sessionVariables = {
        XCURSOR_THEME = "Bibata-Modern-Ice";
        XCURSOR_SIZE = "24";
      };

      programs.zen-browser.enable = true;

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
    };
}
