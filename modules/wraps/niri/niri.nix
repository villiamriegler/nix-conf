{ self, inputs, ... }:
let
  mkNiriWrapped =
    {
      pkgs,
      lib,
      outputs ? { },
    }:
    inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      v2-settings = true;
      settings = {
        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        outputs = outputs;

        layout = {
          gaps = 8;
          background-color = "transparent";
          center-focused-column = "never";

          preset-column-widths = [
            {
              proportion = 0.33333;
            }
            {
              proportion = 0.5;
            }
            {
              proportion = 0.66667;
            }
          ];

          default-column-width = {
            proportion = 0.5;
          };

          focus-ring = {
            width = 2;
            active-color = "#928374";
            inactive-color = "#505050";
          };

          shadow = {
            on = _: { };
            softness = 30;
            spread = 5;
            offset = _: {
              props = {
                x = 0;
                y = 5;
              };
            };
            color = "#0007";
          };
        };

        layer-rules = [
          {
            matches = [
              {
                namespace = "^wallpaper$";
              }
            ];
            place-within-backdrop = true;
          }
        ];

        window-rules = [
          {
            matches = [
              {
                app-id = "kitty";
                is-focused = true;
              }
            ];
            opacity = 0.9;
          }
          {
            matches = [
              {
                app-id = "kitty";
                is-focused = false;
              }
            ];
            opacity = 0.5;
          }
          {
            geometry-corner-radius = 8;
            clip-to-geometry = true;
          }
        ];

        spawn-at-startup = [
          [
            "${lib.getExe pkgs.swaybg}"
            "-i"
            "${./assets/wallpapers/mountain.jpg}"
            "-m"
            "fill"
          ]
          "${lib.getExe pkgs.mako}"
        ];

        prefer-no-csd = _: { };

        screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

        binds = {
          "Mod+T".spawn = [ "${lib.getExe pkgs.kitty}" ];
          "Mod+D".spawn = [ "${lib.getExe pkgs.fuzzel}" ];
          "Super+Alt+L".spawn = [ "${lib.getExe pkgs.hyprlock}" ];

          "Mod+O" = _: {
            props.repeat = false;
            content.toggle-overview = _: { };
          };
          "Mod+Q" = _: {
            props.repeat = false;
            content.close-window = _: { };
          };

          "Mod+Left".focus-column-left = _: { };
          "Mod+Down".focus-window-down = _: { };
          "Mod+Up".focus-window-up = _: { };
          "Mod+Right".focus-column-right = _: { };
          "Mod+L".focus-column-right = _: { };
          "Mod+H".focus-column-left = _: { };
          "Mod+J".focus-window-down = _: { };
          "Mod+K".focus-window-up = _: { };

          "Mod+Ctrl+Left".move-column-left = _: { };
          "Mod+Ctrl+Down".move-window-down = _: { };
          "Mod+Ctrl+Up".move-window-up = _: { };
          "Mod+Ctrl+Right".move-column-right = _: { };
          "Mod+Ctrl+L".move-column-right = _: { };
          "Mod+Ctrl+H".move-column-left = _: { };
          "Mod+Ctrl+J".move-window-down = _: { };
          "Mod+Ctrl+K".move-window-up = _: { };

          "Mod+Shift+Left".focus-monitor-left = _: { };
          "Mod+Shift+Down".focus-monitor-down = _: { };
          "Mod+Shift+Up".focus-monitor-up = _: { };
          "Mod+Shift+Right".focus-monitor-right = _: { };
          "Mod+Shift+L".focus-monitor-right = _: { };
          "Mod+Shift+H".focus-monitor-left = _: { };
          "Mod+Shift+J".focus-monitor-down = _: { };
          "Mod+Shift+K".focus-monitor-up = _: { };

          "Mod+Shift+Ctrl+Left".move-column-to-monitor-left = _: { };
          "Mod+Shift+Ctrl+Down".move-column-to-monitor-down = _: { };
          "Mod+Shift+Ctrl+Up".move-column-to-monitor-up = _: { };
          "Mod+Shift+Ctrl+Right".move-column-to-monitor-right = _: { };
          "Mod+Shift+Ctrl+L".move-column-to-monitor-right = _: { };
          "Mod+Shift+Ctrl+H".move-column-to-monitor-left = _: { };
          "Mod+Shift+Ctrl+J".move-column-to-monitor-down = _: { };
          "Mod+Shift+Ctrl+K".move-column-to-monitor-up = _: { };

          "Mod+Page_Down".focus-workspace-down = _: { };
          "Mod+Page_Up".focus-workspace-up = _: { };
          "Mod+U".focus-workspace-down = _: { };
          "Mod+I".focus-workspace-up = _: { };
          "Mod+Ctrl+Page_Down".move-column-to-workspace-down = _: { };
          "Mod+Ctrl+Page_Up".move-column-to-workspace-up = _: { };
          "Mod+Ctrl+U".move-column-to-workspace-down = _: { };
          "Mod+Ctrl+I".move-column-to-workspace-up = _: { };

          "Mod+WheelScrollDown" = _: {
            props.cooldown-ms = 150;
            content.focus-workspace-down = _: { };
          };
          "Mod+WheelScrollUp" = _: {
            props.cooldown-ms = 150;
            content.focus-workspace-up = _: { };
          };
          "Mod+Ctrl+WheelScrollDown" = _: {
            props.cooldown-ms = 150;
            content.move-column-to-workspace-down = _: { };
          };
          "Mod+Ctrl+WheelScrollUp" = _: {
            props.cooldown-ms = 150;
            content.move-column-to-workspace-up = _: { };
          };

          "Mod+Shift+Page_Down".move-workspace-down = _: { };
          "Mod+Shift+Page_Up".move-workspace-up = _: { };
          "Mod+Shift+U".move-workspace-down = _: { };
          "Mod+Shift+I".move-workspace-up = _: { };

          "Mod+WheelScrollRight".focus-column-right = _: { };
          "Mod+WheelScrollLeft".focus-column-left = _: { };
          "Mod+Ctrl+WheelScrollRight".move-column-right = _: { };
          "Mod+Ctrl+WheelScrollLeft".move-column-left = _: { };

          "Mod+Shift+WheelScrollDown".focus-column-right = _: { };
          "Mod+Shift+WheelScrollUp".focus-column-left = _: { };
          "Mod+Ctrl+Shift+WheelScrollDown".move-column-right = _: { };
          "Mod+Ctrl+Shift+WheelScrollUp".move-column-left = _: { };

          "Mod+1".focus-workspace = 1;
          "Mod+2".focus-workspace = 2;
          "Mod+3".focus-workspace = 3;
          "Mod+4".focus-workspace = 4;
          "Mod+5".focus-workspace = 5;
          "Mod+6".focus-workspace = 6;
          "Mod+7".focus-workspace = 7;
          "Mod+8".focus-workspace = 8;
          "Mod+9".focus-workspace = 9;
          "Mod+Ctrl+1".move-column-to-workspace = 1;
          "Mod+Ctrl+2".move-column-to-workspace = 2;
          "Mod+Ctrl+3".move-column-to-workspace = 3;
          "Mod+Ctrl+4".move-column-to-workspace = 4;
          "Mod+Ctrl+5".move-column-to-workspace = 5;
          "Mod+Ctrl+6".move-column-to-workspace = 6;
          "Mod+Ctrl+7".move-column-to-workspace = 7;
          "Mod+Ctrl+8".move-column-to-workspace = 8;
          "Mod+Ctrl+9".move-column-to-workspace = 9;

          "Mod+BracketLeft".consume-or-expel-window-left = _: { };
          "Mod+BracketRight".consume-or-expel-window-right = _: { };
          "Mod+Comma".consume-window-into-column = _: { };
          "Mod+Period".expel-window-from-column = _: { };

          "Mod+W".toggle-column-tabbed-display = _: { };

          "Mod+R".switch-preset-column-width = _: { };
          "Mod+F".maximize-column = _: { };
          "Mod+Shift+F".fullscreen-window = _: { };

          "Mod+Shift+S".screenshot = _: { };
          "Ctrl+Print".screenshot-screen = _: { };
          "Alt+Print".screenshot-window = _: { };

          "Mod+M".set-dynamic-cast-monitor = _: { };

          "Mod+Shift+P".power-off-monitors = _: { };

          "XF86AudioRaiseVolume" = _: {
            props.allow-when-locked = true;
            content.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+ -l 1.0";
          };
          "XF86AudioLowerVolume" = _: {
            props.allow-when-locked = true;
            content.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-";
          };
          "XF86AudioMute" = _: {
            props.allow-when-locked = true;
            content.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          };
          "XF86AudioMicMute" = _: {
            props.allow-when-locked = true;
            content.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          };

          "XF86AudioPlay" = _: {
            props.allow-when-locked = true;
            content.spawn-sh = "${lib.getExe pkgs.playerctl} play-pause";
          };
          "XF86AudioStop" = _: {
            props.allow-when-locked = true;
            content.spawn-sh = "${lib.getExe pkgs.playerctl} stop";
          };
          "XF86AudioPrev" = _: {
            props.allow-when-locked = true;
            content.spawn-sh = "${lib.getExe pkgs.playerctl} previous";
          };
          "XF86AudioNext" = _: {
            props.allow-when-locked = true;
            content.spawn-sh = "${lib.getExe pkgs.playerctl} next";
          };

          "XF86MonBrightnessUp" = _: {
            props.allow-when-locked = true;
            content.spawn = [
              "${lib.getExe pkgs.brightnessctl}"
              "--class=backlight"
              "set"
              "+10%"
            ];
          };

          "XF86MonBrightnessDown" = _: {
            props.allow-when-locked = true;
            content.spawn = [
              "${lib.getExe pkgs.brightnessctl}"
              "--class=backlight"
              "set"
              "10%-"
            ];
          };
        };
      };
    };
in
{
  flake.nixosModules.Niri =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let 
        cfg = config.window-managers.niri;
    in
    {
      options.window-managers.niri = {
          outputs = lib.mkOption {
              default = { };
              type = lib.types.attrs;
              description = ''
              The outputs to configure for niri. The keys match precicely 
              the original as this is a direct port from:
              https://birdeehub.github.io/nix-wrapper-modules/wrapperModules/niri.html#settingsoutputs 
              '';
          };
      };

      config = {
        programs.niri = {
          enable = true;
          package = mkNiriWrapped {
            inherit pkgs lib;
            outputs = cfg.outputs;
          };
        };

        # Important software for running niri
        # See: https://github.com/niri-wm/niri/wiki/Important-Software
        xdg.portal = {
          enable = true;
          extraPortals = with pkgs; [
            xdg-desktop-portal-gtk
            xdg-desktop-portal-gnome
          ];
        };
        services.gnome.gnome-keyring.enable = true;
        security.polkit.enable = true;
        security.pam.services.hyprlock = { }; # This is an individual choice

        # Audio binds require pipewire to be enabled
        services.pipewire = {
          enable = true;
          pulse.enable = true;
          alsa = {
            enable = true;
            support32Bit = true;
          };
        };
      };
    };
}
