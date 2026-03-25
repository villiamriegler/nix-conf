{ self, inputs, ... }:
{
  flake.nixosModules.base =
    { config, pkgs, ... }:
    {
      fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
      ];
    };
}
