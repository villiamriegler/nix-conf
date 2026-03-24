{ self, inputs, ... }:
{
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.laptopConfiguration

      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs; };

		home-manager.sharedModules = [
			inputs.zen-browser.homeModules.beta
			inputs.nix-index-database.homeModules.default
		];

        home-manager.users.villiamr.imports = [
          self.homeModules.laptop
        ];
      }
    ];
  };
}
