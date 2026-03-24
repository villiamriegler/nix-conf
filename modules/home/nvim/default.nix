{ self, inputs, ... }:
{
  flake.homeModules.nvim =
    {
      inputs,
      config,
      pkgs,
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
            nodePackages.nodejs
            pyright
            python314Packages.python-lsp-server
            java-language-server
            jdt-language-server
            metals
          ]
          ++ [
            inputs.tree-sitter.packages.${pkgs.stdenv.hostPlatform.system}.cli
          ];

      };

      xdg.configFile."nvim" = {
        source = ./conf;
      };
    };
}
