{ self, inputs, ... }:

{
  flake.homeModules.tooling =
    { ... }:
    {
      imports = [
        self.homeModules.tooling-base
      ];
    };
}
