{ self, inputs, config, ... }:
{
  flake.nixosConfigurations.desktop = self.lib.mkHost {
      nixos-modules = [
        self.nixosModules.desktopConfiguration
      ];
      home-modules = [
        self.homeModules.desktop
      ];
  };
}
