{ self, inputs, ... }:
{
  flake.nixosModules.keyboard =
    { config, lib, ... }:
    let
      cfg = config.keyboard;
    in
    {
      options.keyboard = {
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
        services.keyd = {
          enable = true;

          keyboards.default.settings = {
            alt = {
              h = "left";
              j = "down";
              k = "up";
              l = "right";
            };
          };
        };

        services.xserver.xkb = {
          layout = builtins.concatStringsSep "," cfg.layouts;
          options =
            with cfg;
            builtins.concatStringsSep "," [
              toggle-layouts
              lv3-options
            ];
        };
      };
    };
}
