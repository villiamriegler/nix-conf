{ self, inputs, ... }:
{
  flake.nixosModules.keyboard =
    { config, lib, ... }:
    {
      options.internal-modules.keyboard = {
        layouts = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ "se" ];
          description = "List of keyboard layouts to use.";
        };

        toggle-layouts = lib.mkOption {
          type = lib.types.str;
          default = "grp:alt_shift_toggle";
          description = "XKB options to toggle between keyboard layouts.";
        };

        lv3-options = lib.mkOption {
          type = lib.types.str;
          default = "lv3:ralt_switch";
          description = "Extra XKB options for level 3 shift (e.g. right alt).";
        };
      };

      config = {
        services.xserver.xkb = {
          layout = builtins.concatStringsSep "," config.internal-modules.keyboard.layouts;
          options =
            with config.internal-modules.keyboard;
            builtins.concatStringsSep "," [
              toggle-layouts
              lv3-options
            ];
        };
      };
    };
}
