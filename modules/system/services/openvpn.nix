{ self, inputs, ... }:
{
  flake.nixosModules.services =
    { config, pkgs, ... }:
    {
        services.openvpn.servers.dpo = {
            autoStart = false;
            updateResolvConf = true;

            config = ''
            config /etc/openvpn/client/dpo-villiam.ovpn
            '';
        };
    };
}
