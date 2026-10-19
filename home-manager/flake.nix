{
  description = "George - Home Manager configuration";

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
  };
  outputs = {
    nixpkgs,
    home-manager,
    zen-browser,
    nix-index-database,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations."caveman" = nixpkgs.lib.nixosSystem {
      system = system; # e.g., x86_64-linux
      specialArgs = { inherit inputs; };
      modules = [
        # ... your other configuration modules ...
      ];
    };
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.user."caveman" = {
    };

    formatter.${system} = pkgs.alejandra;

    homeConfigurations."caveman" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit nix-index-database; inherit inputs; };
      modules = [
        ./home.nix
      ];
    };
  };
}
