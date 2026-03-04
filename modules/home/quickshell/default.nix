{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    quickshell
	papirus-icon-theme
  	adwaita-icon-theme
  ];

  programs.quickshell = {
    enable = true;
    systemd.enable = true;
  };
}
