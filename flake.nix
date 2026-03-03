{
  description = "NDLOCR-lite NixOS flake modules";

  inputs = {
    inputs.nixpkgs.follows = "nixpkgs";
    pyproject-nix.url = "github:pyproject-nix/pyproject.nix";
    ndlocr-src.url = "github:ndl-lab/ndlocr-lite";
    ndlocr-src.flake = false;
  };

  outputs = {self, ...} @ inputs: {
    nixosModules.ndlocrLite = {pkgs, ...}:
      import ./modules/nixos.nix {
        inherit pkgs inputs;
      };
  };
}
