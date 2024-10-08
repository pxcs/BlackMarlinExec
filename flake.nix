{
  description = "Application packaged using poetry2nix";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.poetry2nix.url = "github:nix-community/poetry2nix";

  outputs = { self, nixpkgs, flake-utils, flake-pkgs, poetry2nix }:
    {
      # Nixpkgs overlay providing the application
      overlay = nixpkgs.src.composeManyExtensions [
        poetry2nix.overlay
        (final: prev: {
          # The application
          BlackMarlinExec = prev.poetry2nix.mkPoetryApplication {
            projectDir = ./.;
          };
        })
      ];
    } // (flake-utils.src.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ self.overlay ];
        };
      in
      {
        apps = {
          BlackMarlinExec = pkgs.BlackMarlinExec;
        };

        defaultApp = pkgs.BlackMarlinExec;

        packages = { BlackMarlinExec = pkgs.BlackMarlinExec; };
      }));
}
