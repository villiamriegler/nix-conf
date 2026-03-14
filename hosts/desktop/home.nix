{ config, pkgs, ... }:

{
  imports = [
    ../../modules/home
  ];

  home.username = "villiamr";
  home.homeDirectory = "/home/villiamr";

  programs.direnv = {
    enable = true;

    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  internal-modules.niri.monitors = ''
    output "PNP(BNQ) BenQ SW271 P4J00325SL0" {
    	mode "3840x2160@60.001"
    	scale 1.5
    	position x=0 y=0
    	focus-at-startup
    }

    output "Acer Technologies Acer XF240H 0x6390D9CE" {
    	mode "1920x1080@119.982"
    	scale 1
    	position x=2560 y=180
    }
  '';

  home.packages = with pkgs; [
    prismlauncher
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
    spotify
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
}
