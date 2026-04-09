{ self, inputs, ... }:
{
  flake.homeModules.zsh =
    { config, pkgs, ... }:
    {
      home.packages = with pkgs; [
        zsh
      ];

      home.file."Templates/devshellTemplate.nix".text = ''
        {
          description = "Devshell template";

          inputs = {
            nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
          };

          outputs =
            { self, nixpkgs, ... }:
            let
              system = "x86_64-linux";
              pkgs = import nixpkgs { inherit system; };
            in
            {
                devShells.''${system}.default = pkgs.mkShell {
                    packages = with pkgs; [];
                };
            };
        }
      '';


      programs.zsh = {
        enable = true;
        oh-my-zsh.enable = true;

        autosuggestion = {
          enable = true;
          # Think about strategy later. Want to try out completion
        };

        history = {
          expireDuplicatesFirst = true;
          ignoreAllDups = true;
        };

        shellAliases = {
          cdconf = "cd ~/.config/nix-conf";
          clear = "clear && fastfetch";
        };

        initContent = ''
          			source ~/.p10k.zsh
          			fastfetch
          		'';
        plugins = [
          {
            name = "powerlevel10k";
            src = pkgs.zsh-powerlevel10k;
            file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
          }
        ];

        siteFunctions = {
          rebuild = ''
            		local default_loc=''${2:-.}
            		sudo nixos-rebuild switch --flake ''$default_loc#''${1:?usage: rebuild <profile> (?<flake_path>)}
          '';
          nix-which = ''
            local dir="/bin"
            local name

            if [ "$1" = "--lib" ]; then
              dir="/lib"
              shift
            fi

            name="$1"

            if [ -z "$name" ]; then
              echo "usage: nix-which [--lib] <name>" >&2
              return 1
            fi

            nix-locate --at-root "''${dir}/''${name}"
          '';
          init-shell = ''
            cat ~/Templates/devshellTemplate.nix > flake.nix
            echo "use flake" > .envrc
            direnv allow
          '';
        };
      };
    };
}
