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
        ];

      };

      home.sessionVariables = {
          EDITOR = "nvim";
      };

      dotfile.nvim.recursive = true;
    };
}
