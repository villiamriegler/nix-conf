{ config, lib, ... }:
let
  cfg = config.internal-modules.gaming;
in
{
	options.internal-modules.gaming = {
		enable = lib.mkEnableOption "Enable steam and gaming realated features";
	};

	config = lib.mkIf cfg.enable {
		# More to come most likely
		programs.steam.enable = true;
	};
}
