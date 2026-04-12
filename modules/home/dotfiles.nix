{self, inputs, ... } : 
{
    flake.homeModules.base = { config, options, pkgs, flake-path, lib, ... }:
    {
        options.dotfile = lib.mkOption {
            description = "Defines an impure mutable dotfile";

            type = lib.types.attrsOf (lib.types.submodule ( {name, ...} : {
                    options = {
                        source = lib.mkOption {
                            type = lib.types.str;
                            default = "${flake-path}/dotfiles/${name}";
                            description = "Path in the dotfiles directory.";
                        };
                        recursive = lib.mkOption {
                            type = lib.types.bool;
                            default = false;
                            description = "Whether to recursively link the directory.";
                        };
                    };
                })
            );
        };

        config = {
            xdg.configFile = lib.mapAttrs' ( name : df : lib.nameValuePair name {
                source = config.lib.file.mkOutOfStoreSymlink df.source;
                recursive = df.recursive;
            }) config.dotfile;
        };
    };
}
