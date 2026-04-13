{ self, inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    let
      tsParsers = with pkgs; [
        vimPlugins.nvim-treesitter-parsers.nix
        vimPlugins.nvim-treesitter-parsers.qmljs
        vimPlugins.nvim-treesitter-parsers.qmldir
      ];

      combinedParsers = pkgs.symlinkJoin {
          name = "treesitter-parsers";
          paths = tsParsers;
      };
    in
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          nixd
          nil
          lua-language-server
          kdePackages.qtdeclarative
        ];

        shellHook = ''
            export TREESITTER_PARSER_DIR=${combinedParsers}
        '';
      };
    };
}
