{...}: {
  services.upower.enable = true;

  services.tlp = {
    enable = true;
    pd.enable = true;

    settings = {
      TLP_ENABLE = 1;
      TLP_PERSISTENT_DEFAULT = 0;
      TLP_WARN_LEVEL = 3;
      TLP_AUTO_SWITCH = 2;

      # --- CPU (Active EPP mode for fast, efficient scaling) ---
      CPU_DRIVER_OPMODE_ON_AC = "active";
      CPU_DRIVER_OPMODE_ON_BAT = "active";
      CPU_DRIVER_OPMODE_ON_SAV = "active";

      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_SCALING_GOVERNOR_ON_SAV = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
      CPU_ENERGY_PERF_POLICY_ON_SAV = "power";

      CPU_SCALING_MIN_FREQ_ON_AC = 0;
      CPU_SCALING_MIN_FREQ_ON_BAT = 0;
      CPU_SCALING_MAX_FREQ_ON_AC = 0;
      CPU_SCALING_MAX_FREQ_ON_BAT = 0;

      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      CPU_BOOST_ON_SAV = 0;

      # --- Platform Profile (TDP / Fan Envelope) ---
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";
      PLATFORM_PROFILE_ON_SAV = "low-power";

      # --- Battery Charge Thresholds (Untouched) ---
      START_CHARGE_THRESH_BAT0 = 1;
      STOP_CHARGE_THRESH_BAT0 = 1;
      RESTORE_THRESHOLDS_ON_BAT = 1;

      # --- AMD GPU & Display (Prevent sub-200MHz clock lock) ---
      RADEON_DPM_PERF_LEVEL_ON_AC = "auto";
      RADEON_DPM_PERF_LEVEL_ON_BAT = "auto";
      RADEON_DPM_PERF_LEVEL_ON_SAV = "auto";

      AMDGPU_ABM_LEVEL_ON_AC = 0;
      AMDGPU_ABM_LEVEL_ON_BAT = 2;
      AMDGPU_ABM_LEVEL_ON_SAV = 3;

      # --- PCIe, Storage, USB & Radio Power Saving ---
      PCIE_ASPM_ON_AC = "default";
      PCIE_ASPM_ON_BAT = "powersupersave";
      PCIE_ASPM_ON_SAV = "powersupersave";

      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";
      RUNTIME_PM_ON_SAV = "auto";

      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";
      WIFI_PWR_ON_SAV = "on";

      USB_AUTOSUSPEND = 1;
      MAX_LOST_WORK_SECS_ON_AC = 15;
      MAX_LOST_WORK_SECS_ON_BAT = 60;

      NMI_WATCHDOG = 0;
      WOL_DISABLE = "Y";

      MEM_SLEEP_ON_AC = "s2idle";
      MEM_SLEEP_ON_BAT = "s2idle";
      MEM_SLEEP_ON_SAV = "s2idle";

      DEVICES_TO_ENABLE_ON_STARTUP = "wifi";
      DEVICES_TO_ENABLE_ON_AC = "wifi";
    };
  };

  services.auto-cpufreq = {
    enable = false;
    settings = {
      charger = {
        governor = "performance";
        turbo = "auto";
      };
      battery = {
        governor = "powersave";
        turbo = "never";
      };
    };
  };
}
