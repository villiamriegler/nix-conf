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

        extraPackages = with pkgs; [
            nodejs_25
            ripgrep
            fd
        ];
      };

      home.sessionVariables = {
          EDITOR = "nvim";
          TREESITTER_QUERY_PATH = "${inputs.nvim-tree-sitter-queries}/runtime";
      };

      dotfile.nvim.recursive = true;
    };
}
