{ self, inputs, ... }:
{
  flake.nixosModules.base =
    { config, pkgs, ... }:
    {
      nixpkgs.overlays = [
        (final: prev: {
          claude-code =
            (import inputs.nixpkgs-master {
              inherit (prev.stdenv.hostPlatform) system;
              config.allowUnfree = true;
            }).claude-code;
        })
      ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;
      nix.settings.auto-optimise-store = true;
      nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
    };
}
