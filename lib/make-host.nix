{ self, inputs, ... }:
{
  flake.lib = {
    mkHost =
      {
        nixos-modules,
        home-modules,
        flake-path ? null
      }:
      inputs.nixpkgs.lib.nixosSystem {

        specialArgs = { inherit flake-path; };

        modules = nixos-modules ++ [
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = { inherit flake-path; };

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };

            home-manager.sharedModules = [
              inputs.zen-browser.homeModules.beta
              inputs.nix-index-database.homeModules.default
            ];

            home-manager.users.${self.meta.identity.username}.imports = home-modules;
          }
        ];
      };
  };
}
