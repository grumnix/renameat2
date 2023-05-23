{
  description = "Command line tool for renameat2 system call";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";

    renameat2_src.url = "https://gist.githubusercontent.com/eatnumber1/f97ac7dad7b1f5a9721f/raw/1c470832ec3e481f06dd10fbe35bd5787871adeb/renameat2.c";
    renameat2_src.flake = false;
  };

  outputs = { self, nixpkgs, flake-utils, renameat2_src }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages = rec {
          default = renameat2;

          renameat2 = pkgs.stdenv.mkDerivation {
            pname = "renameat2";
            version = "0.0.0";

            src = renameat2_src;

            unpackPhase = ''
              cp -vi ${renameat2_src} renameat2.c
            '';

            buildPhase = ''
              $CC renameat2.c -o renameat2
            '';

            installPhase = ''
              mkdir -p $out/bin
              install renameat2 $out/bin
            '';
          };
        };
      }
    );
}
