{
  description = "ndlocr-lite CLI";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};

    src = pkgs.fetchFromGitHub {
      owner = "ndl-lab";
      repo = "ndlocr-lite";
      rev = "master";
      hash = "sha256-7LgCxm+kx6+iVRLl7EIIaaWpSbodPzVgqMmrm2Kd8iI=";
    };
    python = pkgs.python312.withPackages (ps:
      with ps; [
        dill
        lxml
        networkx
        onnxruntime
        pillow
        ordered-set
        protobuf
        pyparsing
        pyyaml
        tqdm
        reportlab
        pypdfium2
        numpy
        opencv-python-headless
      ]);
  in {
    packages.${system}.default = pkgs.writeShellApplication {
      name = "ndlocr-lite-cli";
      runtimeInputs = [python];
      text = ''
        exec python ${src}/src/ocr.py "$@"
      '';
    };
  };
}
