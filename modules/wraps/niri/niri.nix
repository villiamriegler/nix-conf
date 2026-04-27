{ self, inputs, ... }:
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
      basePkg = self.packages.${pkgs.stdenv.hostPlatform.system}.wrapped-niri;
    in
    {
      options.window-managers.niri = {
        settings = lib.mkOption {
          default = { };
          type = lib.types.attrs;
          description = ''
            The settings to configure for niri. The keys match precicely 
            the original as this is a direct port from:
            https://birdeehub.github.io/nix-wrapper-modules/wrapperModules/niri.html#settings          
          '';
        };
      };

      config = {
        programs.niri = {
          enable = true;
          package = basePkg.override (prev: {
            settings = lib.recursiveUpdate prev.settings cfg.settings;
          });
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

  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    let
      mkMenu =
        menu:
        let
          configFile = pkgs.writeText "config.yaml" (
            pkgs.lib.generators.toYAML { } {
              anchor = "bottom-right";
              color = "#ebdbb2";
              border = "#928374";
              background = "#282828";
              border_width = 1;
              inherit menu;
            }
          );
        in
        pkgs.writeShellScriptBin "which-key-menu" ''
          exec ${lib.getExe pkgs.wlr-which-key} ${configFile}
        '';

      callMenu = menu: lib.getExe (mkMenu menu);
    in
    {
      packages.wrapped-niri = pkgs.callPackage ./_package {
        inherit pkgs inputs;
        settings = {
          xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

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
              (lib.getExe self'.packages.Noctalia)
            ]
          ];

          prefer-no-csd = _: { };

          screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

          binds = {
            "Mod+T".spawn = [ "${lib.getExe pkgs.kitty}" ];
            "Mod+D".spawn-sh = [ "${lib.getExe self'.packages.Noctalia} ipc call launcher toggle" ];
            "Mod+P".spawn-sh = [ "${lib.getExe self'.packages.Noctalia} ipc call sessionMenu toggle" ];

            "Mod+Q" = _: {
              props.repeat = false;
              content.close-window = _: { };
            };

            "Mod+L".focus-column-right = _: { };
            "Mod+H".focus-column-left = _: { };
            "Mod+J".focus-window-down = _: { };
            "Mod+K".focus-window-up = _: { };

            "Mod+M".spawn-sh = callMenu [
              {
                key = "h";
                desc = "Move column left";
                cmd = "niri msg action move-column-left";
              }
              {
                key = "l";
                desc = "Move column right";
                cmd = "niri msg action move-column-right";
              }
              {
                key = "j";
                desc = "Move window down";
                cmd = "niri msg action move-window-down";
              }
              {
                key = "k";
                desc = "Move window up";
                cmd = "niri msg action move-window-up";
              }
              {
                key = "t";
                desc = "Toggle tabbed mode";
                cmd = "niri msg action toggle-column-tabbed-display";
              }
              {
                key = "o";
                desc = "Move across outputs";
                submenu = [
                  {
                    key = "h";
                    desc = "Move to monitor left";
                    cmd = "niri msg action move-column-to-monitor-left";
                  }
                  {
                    key = "l";
                    desc = "Move to monitor right";
                    cmd = "niri msg action move-column-to-monitor-right";
                  }
                  {
                    key = "j";
                    desc = "Move to monitor down";
                    cmd = "niri msg action move-column-to-monitor-down";
                  }
                  {
                    key = "k";
                    desc = "Move to monitor up";
                    cmd = "niri msg action move-column-to-monitor-up";
                  }
                ];
              }
              {
                key = "w";
                desc = "Move across workspaces";
                submenu = [
                  {
                    key = "j";
                    desc = "Move to workspace down";
                    cmd = "niri msg action move-column-to-workspace-down";
                  }
                  {
                    key = "k";
                    desc = "Move to workspace up";
                    cmd = "niri msg action move-column-to-workspace-up";
                  }
                ];
              }
              {
                key = "c";
                desc = "Consume into";
                submenu = [
                  {
                    key = "h";
                    desc = "Consume into left";
                    cmd = "niri msg action consume-or-expel-window-left";
                  }
                  {
                    key = "l";
                    desc = "Consume into right";
                    cmd = "niri msg action consume-or-expel-window-right";
                  }
                ];
              }
            ];

            # Have never used these, if they may be useful 
            # probably move them into mod+m or mod+w
            "Mod+Shift+Alt+J".move-workspace-down = _: { };
            "Mod+Shift+Alt+K".move-workspace-up = _: { };

            "Mod+W".spawn-sh = callMenu [
              {
                key = "j";
                desc = "Focus workspace down";
                cmd = "niri msg action focus-workspace-down";
              }
              {
                key = "k";
                desc = "Focus workspace up";
                cmd = "niri msg action focus-workspace-up";
              }
            ];

            "Mod+O".spawn-sh = callMenu [
              {
                key = "o";
                desc = "Toggle overview";
                cmd = "niri msg action toggle-overview";
              }
              {
                key = "l";
                desc = "Focus output right";
                cmd = "niri msg action focus-monitor-right";
              }
              {
                key = "h";
                desc = "Focus output left";
                cmd = "niri msg action focus-monitor-left";
              }
              {
                key = "j";
                desc = "Focus output down";
                cmd = "niri msg action focus-monitor-down";
              }
              {
                key = "k";
                desc = "Focus output up";
                cmd = "niri msg action focus-monitor-up";
              }
            ];

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

            "Mod+R".switch-preset-column-width = _: { };
            "Mod+F".maximize-column = _: { };
            "Mod+Shift+F".fullscreen-window = _: { };

            "Mod+Shift+S".screenshot = _: { };
            "Ctrl+Print".screenshot-screen = _: { };
            "Alt+Print".screenshot-window = _: { };

            # "Mod+M".set-dynamic-cast-monitor = _: { };

            "XF86AudioRaiseVolume" = _: {
              props.allow-when-locked = true;
              content.spawn-sh = "${lib.getExe self'.packages.Noctalia} ipc call volume increase";
            };
            "XF86AudioLowerVolume" = _: {
              props.allow-when-locked = true;
              content.spawn-sh = "${lib.getExe self'.packages.Noctalia} ipc call volume decrease";
            };
            "XF86AudioMute" = _: {
              props.allow-when-locked = true;
              content.spawn-sh = "${lib.getExe self'.packages.Noctalia} ipc call volume muteOutput";
            };
            "XF86AudioMicMute" = _: {
              props.allow-when-locked = true;
              content.spawn-sh = "${lib.getExe self'.packages.Noctalia} ipc call volume muteInput";
            };

            "XF86AudioPlay" = _: {
              props.allow-when-locked = true;
              content.spawn-sh = "${lib.getExe self'.packages.Noctalia} ipc call media playPause";
            };
            "XF86AudioStop" = _: {
              props.allow-when-locked = true;
              content.spawn-sh = "${lib.getExe self'.packages.Noctalia} ipc call media pause";
            };
            "XF86AudioPrev" = _: {
              props.allow-when-locked = true;
              content.spawn-sh = "${lib.getExe self'.packages.Noctalia} ipc call media previous";
            };
            "XF86AudioNext" = _: {
              props.allow-when-locked = true;
              content.spawn-sh = "${lib.getExe self'.packages.Noctalia} ipc call media next";
            };
            "XF86MonBrightnessUp" = _: {
              props.allow-when-locked = true;
              content.spawn-sh = "${lib.getExe self'.packages.Noctalia} ipc call brightness increase";
            };
            "XF86MonBrightnessDown" = _: {
              props.allow-when-locked = true;
              content.spawn-sh = "${lib.getExe self'.packages.Noctalia} ipc call brightness decrease";
            };
          };
        };
      };
    };
}
