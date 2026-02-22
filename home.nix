{ config, pkgs, ... }:

{
  imports = [
    ./modules/home
  ];

  home.username = "villiamr";
  home.homeDirectory = "/home/villiamr";

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
