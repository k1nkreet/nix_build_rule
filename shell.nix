{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    nativeBuildInputs = [
      pkgs.buildPackages.grpcurl
      pkgs.buildPackages.docker-compose
    ];
}

