{pkgs, ...}: {
  programs.vicinae = {
    enable = true;
    package = pkgs.vicinae;
    settings = {
      launcher_window.layer_shell.enabled = true;
      theme = {
        dark = {
          name = "matugen";
        };
        light = {
          name = "matugen";
        };
      };
    };
  };
}
