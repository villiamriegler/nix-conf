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
      };

      dotfile.nvim.recursive = true;
    };
}
