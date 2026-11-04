{...}: {
  services.upower.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      TLP_ENABLE = 1;
      TLP_PERSISTENT_DEFAULT = 0;
      TLP_WARN_LEVEL = 3;
      TLP_AUTO_SWITCH = 2;

      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

      CPU_SCALING_MIN_FREQ_ON_AC = 0;
      CPU_SCALING_MIN_FREQ_ON_BAT = 0;
      CPU_SCALING_MAX_FREQ_ON_AC = 0;
      CPU_SCALING_MAX_FREQ_ON_BAT = 0;

      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "balanced";
      PLATFORM_PROFILE_ON_SAV = "low-power";

      START_CHARGE_THRESH_BAT0 = 1;
      STOP_CHARGE_THRESH_BAT0 = 1;

      RESTORE_THRESHOLDS_ON_BAT = 1;

      RADEON_DPM_PERF_LEVEL_ON_AC = "auto";
      RADEON_DPM_PERF_LEVEL_ON_SAV = "low";
      RADEON_DPM_PERF_LEVEL_ON_BAT = "auto";

      AMDGPU_ABM_LEVEL_ON_AC = 0;
      AMDGPU_ABM_LEVEL_ON_BAT = 2;

      NMI_WATCHDOG = 0;

      WOL_DISABLE = "Y";

      MEM_SLEEP_ON_AC = "s2idle";
      MEM_SLEEP_ON_BAT = "s2idle";
      MEM_SLEEP_ON_SAV = "deep";

      DEVICES_TO_ENABLE_ON_STARTUP = "wifi";
      DEVICES_TO_ENABLE_ON_AC = "wifi";

      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";
    };
  };

  services.auto-cpufreq.enable = false;
  services.auto-cpufreq.settings = {
    charger = {
      governor = "performance";
      turbo = "auto";
    };
    battery = {
      governor = "powersave";
      turbo = "never";
    };
  };
}
