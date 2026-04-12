{ self, inputs, config, ... }:
{
  flake.nixosConfigurations.laptop = self.lib.mkHost {
      flake-path = "/home/${self.meta.identity.username}/.config/nix-conf";

      nixos-modules = [
        self.nixosModules.laptopConfiguration
      ];
      home-modules = [
        self.homeModules.laptop
      ];
  };
}
