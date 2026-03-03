{pkgs, ...}: let
  ndlocrLite = pkgs.python310Packages.buildPythonPackage rec {
    pname = "ndlocrLite";
    version = "unstable";

    src = pkgs.fetchFromGitHub {
      owner = "ndl-lab";
      repo = "ndlocr-lite";
      rev = "master";
      sha256 = "sha256-1piclqni01x6m35yi49zbyyz3sjrb4clwxw1608g7xyiw6ansgf5";
    };

    # pyproject.toml を使う場合は、poetry や setuptools を使う
    buildInputs = [pkgs.poetry pkgs.python310 pkgs.python310Packages.setuptools];

    # 不要なテストをスキップする場合
    doCheck = false;
  };
in {
  environment.systemPackages = [ndlocrLite];
}
