{ self, inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          nixd
          nil
          lua-language-server
          kdePackages.qtdeclarative
        ];
      };
    };
}
