# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ self, inputs, ... }:

{
  flake.nixosModules.desktopConfiguration =
    { pkgs, lib, ... }:
    {
      imports = [
        # Include the results of the hardware scan.
        self.nixosModules.base
        self.nixosModules.common
        self.nixosModules.gaming
        self.nixosModules.nvidia
        self.nixosModules.keyboard
        self.nixosModules.Niri
      ];

      # Bootloader.
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking.hostName = "desktop-nixos"; # Define your hostname.

      window-managers.niri.settings.outputs = {
        "PNP(BNQ) BenQ SW271 P4J00325SL0" = {
          mode = "3840x2160@60.001";
          scale = 1.5;
          position = _: {
            props = {
              x = 0;
              y = 0;
            };
          };
          focus-at-startup = _: { };
        };
        "Acer Technologies Acer XF240H 0x6390D9CE" = {
          mode = "1920x1080@119.982";
          scale = 1;
          position = _: {
            props = {
              x = 2560;
              y = 180;
            };
          };
        };
      };

      internal-modules = {
        nvidia.enable = true;
        gaming.enable = true;

        keyboard.layouts = [
          "us"
          "swerty"
        ];
      };

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "25.11"; # Did you read the comment?
    };
}
