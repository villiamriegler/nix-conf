{ self, inputs, ... }:
{
  flake.homeModules.quickshell =
    { config, pkgs, flake-path, ... }:
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

      dotfile.quickshell.recursive = true;
    };
}
