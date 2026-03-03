{ ... }:
{
  imports = [
    ./swerty.nix
  ];

  services.xserver.xkb = {
    layout = "us,swerty";
    options = "grp:alt_shift_toggle,lv3:ralt_switch";
  };
}
