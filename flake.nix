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

    patchedSrc = pkgs.stdenv.mkDerivation {
      pname = "ndlocr-lite";
      version = "patched";

      src = origSrc;
      patches = [
        (pkgs.fetchurl
          {
            url = "https://raw.githubusercontent.com/kaede-0323/ndlocr-lite-stdout-patch/master/stdout_patch.diff";
            sha256 = "03bj5fzhcl8pn2jjkw65av6nb4w7d9mkms5ki3xqpnng5shc7pfl";
          })
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
