{ self, inputs, ... }:

{
  flake.homeModules.tooling-base =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        fd
        jq
        gh
        ast-grep
        python3
        uv

        devenv

        easyrsa
        openvpn
      ];
    };
}
