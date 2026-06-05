{self, inputs, ... } : {
	flake.homeModules.base = { config, pkgs, flake-path, lib, ... }:
	{
      imports = [
        self.homeModules.tooling
      ];

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
        hledger
        fzf
        lazygit
        fastfetch
        discord
        tree
        firefox
        obsidian
        claude-code
      ];

      home.sessionVariables = {
          LEDGER_FILE = "${config.home.homeDirectory}/Finance/2026.journal";
          FLAKE_PATH = flake-path;
      };
	};
}
