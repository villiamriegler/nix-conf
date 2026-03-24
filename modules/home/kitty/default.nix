{ self, inputs, ... }:

{
  flake.homeModules.kitty =
    { config, pkgs, ... }:
    {
      programs.kitty = {
        enable = true;
        shellIntegration.enableZshIntegration = true;
        enableGitIntegration = true;

        font.name = "JetBrainsMono NF";
        font.package = pkgs.nerd-fonts.jetbrains-mono;

        themeFile = "gruvbox-dark";

        extraConfig = ''
          	enable_audio_bell no
        '';
      };

    };
}
