{
  description = "Nix flake for verifying the Riemann Hypothesis";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    { nixpkgs, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];

      perSystem = { system, pkgs, ... }: {
        packages.default = with pkgs; leanPackages.buildLakePackage {
          pname = "riemann-hypothesis";
          version = "0.1.0";

          src = stdenvNoCC.mkDerivation {
            name = "lean.tar.gz";

            nativeBuildInputs = [ curl ];
            SSL_CERT_FILE = "${cacert}/etc/ssl/certs/ca-bundle.crt";

            buildCommand = ''
              for n in {1..14}; do
                curl https://alpo.ge/lean.tar.gz.part$(printf %02d $n) >> $out
              done
            '';

            outputHashMode = "flat";
            outputHash = "sha256-ljG08CAZnlgLqGF4y1bG6bCfaQwjaagNxDNKqT9Jx/w=";
          };

          leanDeps = with leanPackages; [
            mathlib
            plausible
            LeanSearchClient
            importGraph
            proofwidgets
            aesop
            Qq
            batteries
            Cli
          ];
          lakeHash = "sha256-pQpattmS9VmO3ZIQUFn66az8GSmB4IvYhTTCFn6SUmo=";
        };
      };

      flake = {};
    };
}
