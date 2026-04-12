{self, inputs, ...} : {
    perSystem = {pkgs, ...} : {
        devShells.default = pkgs.mkShell {
            packages = with pkgs; [
                nixd
                nil
                lua-language-server
                kdePackages.qtdeclarative

                vimPlugins.nvim-treesitter-parsers.nix
                vimPlugins.nvim-treesitter-parsers.lua
                vimPlugins.nvim-treesitter-parsers.qmljs
                vimPlugins.nvim-treesitter-parsers.qmldir
            ];
        };
    };
}
