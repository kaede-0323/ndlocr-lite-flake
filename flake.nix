{
  description = "NDLOCR-lite NixOS/Home-Manager flake modules";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  }: {
    nixosModules.ndlocrLite = import ./modules/nixos.nix;
    homeManagerModules.ndlocrLite = import ./modules/home-manager.nix;
  };
}
