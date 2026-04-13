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

      tsParsers = with pkgs; [ ];

      combinedParsers = pkgs.symlinkJoin {
        name = "treesitter-parsers";
        paths = tsParsers;
      };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [ ];

        shellHook = ''
          export TREESITTER_PARSER_DIR=${combinedParsers}
        '';
      };
    };
}
