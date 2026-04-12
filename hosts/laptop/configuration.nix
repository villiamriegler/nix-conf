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
        "eDP-1" = {
          mode = "1920x1200@59.88";
          position = _: {
            props = {
              x = 0;
              y = 0;
            };
          };
          focus-at-startup = _: { };
        };
      };

      keyboard.layouts = [ "se" ];

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "25.11"; # Did you read the comment?
    };
}
