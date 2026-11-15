{pkgs, ...}: {
  services.greetd = {
    enable = true;

    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --greeting 'Welcome to NixOS' --theme 'border=red;text=white;prompt=yellow;time=red;action=yellow;button=red;container=black;input=white' --background doom --background-fps 30";
        user = "greeter";
      };
    };
  };
}
