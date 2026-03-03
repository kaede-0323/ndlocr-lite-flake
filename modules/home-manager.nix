{pkgs, ...}: let
  ndlocr-lite = pkgs.python310Packages.buildPythonPackage rec {
    pname = "ndlocr-lite";
    version = "unstable";

    src = pkgs.fetchFromGitHub {
      owner = "ndl-lab";
      repo = "ndlocr-lite";
      rev = "master";
      sha256 = "sha256-1piclqni01x6m35yi49zbyyz3sjrb4clwxw1608g7xyiw6ansgf5";
    };

    buildInputs = [pkgs.poetry pkgs.python310 pkgs.python310Packages.setuptools];
    doCheck = false;
  };
in {
  home.packages = [ndlocr-lite];
}
