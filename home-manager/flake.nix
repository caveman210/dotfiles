{
  description = "George - Home Manager configuration";

  nixConfig = {
    extra-substituters = [ "https://codex-desktop-linux.cachix.org" ];
    extra-trusted-public-keys = [
      "codex-desktop-linux.cachix.org-1:nX/xy6AdK9hQE24A8ALGjkCKj2ObFmcnemiL5Cid4nk="
    ];
  };

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.zst";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    antigravity = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    codex-desktop-linux = {
      url = "github:ilysenko/codex-desktop-linux";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zapfast-wa = {
      url = "github:crmne/zapfast";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    nixpkgs,
    home-manager,
    zen-browser,
    nix-index-database,
    antigravity,
    codex-desktop-linux,
    zapfast-wa,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  in {
    nixosConfigurations."caveman" = nixpkgs.lib.nixosSystem {
      system = system; # e.g., x86_64-linux
      specialArgs = {inherit inputs;};
      modules = [
        {
          nixpkgs.hostPlatform = system;
        }
      ];
    };
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.user."caveman" = {
      xdg.mimeApps = {
        enable = true;

        defaultApplications = {
          # Websites
          "text/html" = "zen-beta.desktop";
          "x-scheme-handler/http" = "zen-beta.desktop";
          "x-scheme-handler/https" = "zen-beta.desktop";
          "x-scheme-handler/about" = "zen-beta.desktop";
          "x-scheme-handler/unknown" = "zen-beta.desktop";

          # PDFs
          "application/pdf" = "org.pwmt.zathura.desktop";

          # Images
          "image/jpeg" = "feh.desktop";
          "image/png" = "feh.desktop";
          "image/gif" = "feh.desktop";
          "image/webp" = "feh.desktop";
          "image/bmp" = "feh.desktop";
          "image/tiff" = "feh.desktop";
          "image/svg+xml" = "feh.desktop";

          # Code / Text
          "text/plain" = "nvim.desktop";
          "text/x-c" = "nvim.desktop";
          "text/x-c++" = "nvim.desktop";
          "text/x-python" = "nvim.desktop";
          "text/x-shellscript" = "nvim.desktop";
          "text/x-java" = "nvim.desktop";
          "text/x-rust" = "nvim.desktop";
          "text/x-go" = "nvim.desktop";
          "application/json" = "nvim.desktop";
          "application/xml" = "nvim.desktop";
          "text/markdown" = "nvim.desktop";
        };
      };
    };

    formatter.${pkgs.stdenv.hostPlatform.system} = pkgs.alejandra;

    homeConfigurations."caveman" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit nix-index-database;
        inherit inputs;
        inherit antigravity;
        inherit codex-desktop-linux;
        inherit zapfast-wa;
      };
      modules = [
        ./home.nix
      ];
    };
  };
}
