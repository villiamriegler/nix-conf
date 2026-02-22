{ config, pkgs, ... } : 

{
	programs.kitty = {
		enable = true;
		shellIntegration.enableZshIntegration = true;
		enableGitIntegration = true;

		themeFile = "gruvbox-dark";

		extraConfig = '' 
		enable_audio_bell no
		'';
	};
}
