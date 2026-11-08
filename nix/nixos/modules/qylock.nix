{...}: {
  programs.qylock = {
    enable = true;
    theme = "sword";

    themeOptions = {
      terraria.backgroundMode = "time";
      Genshin.backgroundMode = "time";
      clockwork.orbital = {
        themeMode = "dark";
        enableWindup = true;
      };
      osu.gameMode = "menu";
      sddm.enable = true;
    };
  };

  # Display Manager Setup
  # services.displayManager.sddm.enable = true;
  # services.displayManager.sddm.wayland.enable = true;
}
