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

      xdg.configFile."quickshell" = {
          source = config.lib.file.mkOutOfStoreSymlink "${flake-path}/dotfiles/quickshell";
          recursive = true;
      };
    };
}
