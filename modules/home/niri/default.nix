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

    keyboard-layouts = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "se" ];
      description = "List of keyboard layouts to use.";
    };

    toggle-keyboard-layouts = lib.mkOption {
      type = lib.types.str;
      default = "grp:alt_shift_toggle";
      description = "XKB options to toggle between keyboard layouts.";
    };

    keyboard-lv3-options = lib.mkOption {
      type = lib.types.str;
      default = "lv3:ralt_switch";
      description = "Extra XKB options for level 3 shift (e.g. right alt).";
    };

  };

  config = {

    xdg.configFile."niri/config.kdl".text =
      let
        base = builtins.readFile ./config.kdl;
        layout = builtins.concatStringsSep "," config.internal-modules.niri.keyboard-layouts;
        options =
          with config.internal-modules.niri;
          builtins.concatStringsSep "," [
            toggle-keyboard-layouts
            keyboard-lv3-options
          ];
        keyboard = ''
		input {
			keyboard {
				xkb {
					layout "${layout}"
					options "${options}"
				}
			}

			touchpad {
				tap 
				natural-scroll
			}
		}
        '';
      in
      ''
        	${base}
        	${cfg.monitors}
			${keyboard}
      '';
  };
}
