{self, inputs, ...} : {

    perSystem = {pkgs, ...} : {
        packages.Noctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
            inherit pkgs;
            settings = (builtins.fromJSON (builtins.readFile ./_conf/settings.json));
        };
    };
}
