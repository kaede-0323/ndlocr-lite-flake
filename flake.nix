{
  description = "NDLOCR-lite NixOS flake modules";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    pyproject-nix.url = "github:pyproject-nix/pyproject.nix";
    ndlocr-src.url = "github:ndl-lab/ndlocr-lite";
    ndlocr-src.flake = false;
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: {
    nixosModules.ndlocrLite = import ./modules/nixos.nix;
  };
}
