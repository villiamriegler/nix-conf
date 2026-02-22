{config, pkgs, ...} : 

{
	home.packages = with pkgs; [
		zsh
	];


	programs.zsh = {
		enable = true;
		oh-my-zsh.enable = true;
		
		autosuggestion = {
			enable = true;
			# Think about strategy later. Want to try out completion
		};
		
		history = {
			expireDuplicatesFirst = true;
			ignoreAllDups = true;
		};

		shellAliases = {
			cdconf = "cd ~/.config/nixos-conf";
		};
		initContent = ''
			source ~/.p10k.zsh
		'';
		plugins = [
			{name = "powerlevel10k";src = pkgs.zsh-powerlevel10k;file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";}

		];
		siteFunctions = {
			rebuild = ''
				local default_loc=''${2:-.}
				sudo nixos-rebuild switch --flake ''$default_loc#''${1:?usage: rebuild <profile> (?<flake_path>)}
			'';
		};

	};
}
