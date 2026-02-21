{
  description = "A very basic flake";

  inputs = {
    	nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
	home-manager = {
		url = "github:nix-community/home-manager";
		inputs.nixpkgs.follows = "nixpkgs";
	};
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let 
    # Directory containing host definitions. 
    # A host definition defines the system where the configuration should run.
    hostsDir = ./hosts;

    # Extracts all the hostnames from the hostsDir
    hostNames = builtins.attrNames (
      nixpkgs.lib.filterAttrs ( _ : type: type == "directory" ) (builtins.readDir hostsDir)
    );

    # Creates a system configuration from a host definition 
    mkHost = {hostname} : nixpkgs.lib.nixosSystem {
      modules = [ 
        (hostsDir + "/${hostname}/configuration.nix")
	home-manager.nixosModules.home-manager {
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.users.villiamr = ./home.nix;
        }
      ];
    };

    # Host systems defined from the host definitions
    hosts = builtins.listToAttrs (map (hostname : {
        name = hostname;
        value = mkHost { hostname = hostname; };
      }) hostNames
    );
  in
  {
    nixosConfigurations = hosts;
  };
}
