{self, inputs, ... } : {
	flake.homeModules.base = { config, pkgs, lib, ... }:
	{
      programs.direnv = {
        enable = true;

        enableZshIntegration = true;
        nix-direnv.enable = true;
      };

      programs.zen-browser.enable = true;

      services.polkit-gnome.enable = true;

      programs.git = {
        enable = true;
        settings = {
          user.name = self.meta.identity.name;
          user.email = self.meta.identity.email;
        };
      };

      home.packages = with pkgs; [
        git
        lazygit
        fastfetch
        discord
        tree
        firefox
        obsidian
      ];
	};
}
