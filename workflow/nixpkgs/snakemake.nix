{ pkgs

,
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "snakemake";
  version = "7.32.4";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "fdc3f15dd7b06fabb7da30d460e0a3b1fba08e4ea91f9c32c47a83705cdc7b6e";
  };

  propagatedBuildInputs = [
    pkgs.python310Packages.configargparse
    pkgs.python310Packages.datrie
    pkgs.python310Packages.humanfriendly
    pkgs.python310Packages.immutables
    pkgs.python310Packages.pulp
    pkgs.python310Packages.reretry
    pkgs.python310Packages.smart-open
    pkgs.python310Packages.tabulate
    pkgs.python310Packages.throttler
    pkgs.python310Packages.toposort
    pkgs.python310Packages.tomli
    pkgs.python310Packages.wrapt
    pkgs.python310Packages.yte
  ];

  doCheck = false;

}
