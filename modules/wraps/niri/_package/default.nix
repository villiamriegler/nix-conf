{pkgs, inputs, settings ? {}, ...} : 
inputs.wrapper-modules.wrappers.niri.wrap {
    inherit pkgs settings;
    v2-settings = true;
}

