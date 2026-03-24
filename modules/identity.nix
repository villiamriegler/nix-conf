{ self, inputs, ... }:
{
  flake.meta.identity = {
    username = "villiamr";
    email = "ville@riegler.se";
	name = "Villiam Riegler";
  };

  flake.homeModules.base =
    {
      config,
      ...
    }:
    {
      home.username = self.meta.identity.username;
      home.homeDirectory = "/home/${self.meta.identity.username}";
    };

  flake.nixosModules.base =
    {
      config,
      ...
    }:
    {
      users.users.${self.meta.identity.username} = {
        isNormalUser = true;
        description = self.meta.identity.username;
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
      };
    };
}
