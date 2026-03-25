{ self, inputs, ... }:

{
  flake.nixosModules.common =
    { config, pkgs, ... }:
    {
	  imports = [
	  	self.nixosModules.locale-se
	  ];

      services.upower.enable = true;

      # Define a user account. Don't forget to set a password with ‘passwd’.
      users.users.${self.meta.identity.username} = {
        shell = pkgs.zsh;
        packages = with pkgs; [
          google-chrome
        ];
      };

      # List packages installed in system profile. To search, run:
      # $ nix search wget
      environment.systemPackages = with pkgs; [
        vim
        wget
        niri
        xwayland-satellite
      ];

      services.displayManager.gdm.enable = true;
      programs.niri.enable = true;
      programs.zsh.enable = true;


      xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-gnome
        ];
      };

      services.gnome.gnome-keyring.enable = true;
      services.libinput.enable = true;

      security.polkit.enable = true;
      security.pam.services.hyprlock = { };

      # Some programs need SUID wrappers, can be configured further or are
      # started in user sessions.
      # programs.mtr.enable = true;
      # programs.gnupg.agent = {
      #   enable = true;
      #   enableSSHSupport = true;
      # };

      # List services that you want to enable:

      # Enable the OpenSSH daemon.
      services.openssh.enable = true;

      # Open ports in the firewall.
      # networking.firewall.allowedTCPPorts = [ ... ];
      # networking.firewall.allowedUDPPorts = [ ... ];
      # Or disable the firewall altogether.
      # networking.firewall.enable = false;
    };
}
