{ config, lib, ... }:
{
  flake.nixosModules.gaming =
    { ... }:
    {
      programs.steam.enable = true;
    };
}
