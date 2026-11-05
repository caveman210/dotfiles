{
  description = "George - Home Manager configuration";

  nixConfig = {
    extra-substituters = [ "https://codex-desktop-linux.cachix.org" ];
    extra-trusted-public-keys = [
      "codex-desktop-linux.cachix.org-1:nX/xy6AdK9hQE24A8ALGjkCKj2ObFmcnemiL5Cid4nk="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
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
  };
  outputs = {
    nixpkgs,
    home-manager,
    zen-browser,
    nix-index-database,
    antigravity,
    codex-desktop-linux,
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
    };

    formatter.${pkgs.stdenv.hostPlatform.system} = pkgs.alejandra;

    homeConfigurations."caveman" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit nix-index-database;
        inherit inputs;
        inherit antigravity;
        inherit codex-desktop-linux;
      };
      modules = [
        ./home.nix
      ];
    };
  };
}
