# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ self, inputs, ... }:

{
  flake.nixosModules.laptopConfiguration =
    { pkgs, lib, ... }:
    {
      imports = [
        self.nixosModules.base
        self.nixosModules.common
        self.nixosModules.keyboard
        self.nixosModules.Niri
      ];

      # Bootloader.
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking.hostName = "laptop-nixos"; # Define your hostname.

      window-managers.niri.settings.outputs = {
        "HDMI-A-1" = {
          mode = "3840x2160@59.997";
          scale = 1.5;
          position = _: {
            props = {
              x = 0;
              y = 0;
            };
          };
        };
        "DP-1" = {
          mode = "3840x2160@59.997";
          scale = 1.5;
          position = _: {
            props = {
              x = 2560;
              y = 0;
            };
          };
        };
        "eDP-1" = {
          mode = "1920x1200@60.001";
          scale = 1.25;
          position = _: {
            props = {
              x = 2560;
              y = 240;
            };
          };
          focus-at-startup = _: { };
        };
      };

      keyboard.layouts = [
        "us"
        "swerty"
        "se"
      ];

      hardware.bluetooth.enable = true;
      services.blueman.enable = true;

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "25.11"; # Did you read the comment?
    };
}
