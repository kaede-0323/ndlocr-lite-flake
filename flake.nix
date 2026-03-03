{
  description = "ndlocr-lite CLI";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};

    origSrc = pkgs.fetchFromGitHub {
      owner = "ndl-lab";
      repo = "ndlocr-lite";
      rev = "master";
      hash = "sha256-7LgCxm+kx6+iVRLl7EIIaaWpSbodPzVgqMmrm2Kd8iI=";
    };

    patchFileSrc = pkgs.fetchFromGitHub {
      owner = "kaede-0323";
      repo = "ndlocr-lite-stdout-patch";
      rev = "master";
      hash = "sha256-veaOVlOgPWWih7APiIJY5aeMTMqKvW8Pz3pZpWxjrJ8=";
    };

    patchedSrc = pkgs.stdenv.mkDerivation {
      pname = "ndlocr-lite";
      version = "patched-0.0.2";

      src = origSrc;
      patches = [
        "${patchFileSrc}/stdout_patch.diff"
        "${patchFileSrc}/stderr.diff"
      ];

      installPhase = ''
        mkdir -p $out
        cp -r * $out/
      '';
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
        exec python ${patchedSrc}/src/ocr.py "$@"
      '';
    };
  };
}
