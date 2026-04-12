{ self, inputs, config, ... }:
{
  flake.nixosConfigurations.desktop = self.lib.mkHost {
      flake-path = "/home/${self.meta.identity.username}/.config/nix-conf";

      nixos-modules = [
        self.nixosModules.desktopConfiguration
      ];
      home-modules = [
        self.homeModules.desktop
      ];
  };
}
