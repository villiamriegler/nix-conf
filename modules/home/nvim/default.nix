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
	sideloadInitLua = true;
	defaultEditor = true;

        extraPackages = with pkgs; [
            nodejs_25
            ripgrep
            fd
            tree-sitter
        ];
      };

      dotfile.nvim.recursive = true;
    };
}
