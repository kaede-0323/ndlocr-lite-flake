{
  pkgs,
  inputs,
  ...
}: let
  python = pkgs.python3;

  project = inputs.pyproject-nix.lib.project.loadPyproject {
    projectRoot = inputs.ndlocr-src;
  };

  ndlocrLite = inputs.pyproject-nix.lib.project.mkPythonPackage {
    inherit pkgs python project;
  };
in {
  environment.systemPackages = [ndlocrLite];
}
