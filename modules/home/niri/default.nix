{ config, lib, ... }:
let
  cfg = config.internal-modules.niri;
in
{
  options.internal-modules.niri = {
    monitors = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "List of monitors to use with Niri.";
    };
  };

  config = {

    xdg.configFile."niri/config.kdl".text =
      let
        base = builtins.readFile ./config.kdl;
      in
      ''
        	${base}
        	${cfg.monitors}
      '';
  };
}
