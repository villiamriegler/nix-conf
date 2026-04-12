{ self, inputs, config, ... }:
{
  flake.nixosConfigurations.laptop = self.lib.mkHost {
      nixos-modules = [
        self.nixosModules.laptopConfiguration
      ];
      home-modules = [
        self.homeModules.laptop
      ];
  };
}
