{ self, inputs, ... }:
{
  flake.homeModules.nvim =
    {
      inputs,
      config,
      pkgs,
      flake-path,
      ...
    }:
    {
      programs.neovim = {
        enable = true;

        extraPackages =
          with pkgs;
          [
            unzip
            kdePackages.qtdeclarative
            lua-language-server
            gnumake
            gcc
            nixd
            nil
            ripgrep
            fd
            luarocks
            python3
            pyright
            python314Packages.python-lsp-server
            java-language-server
            jdt-language-server
			haskell-language-server
            metals
          ]
          ++ [
            inputs.tree-sitter.packages.${pkgs.stdenv.hostPlatform.system}.cli
          ];

      };

      home.sessionVariables = {
          EDITOR = "nvim";
      };

      dotfile.nvim.recursive = true;
    };
}
