{ pkgs

, graphtools
, scprep
, sgd2
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "phate";
  version = "1.0.11";
  format = "pyproject";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "10162e9edd09ce5d0e667b0767e96eed6bda5ee877667202ffff0a578ab5076d";
  };

  propagatedBuildInputs = [
    #stp
    #pkgs.python310Packages.toml
    #pkgs.python310Packages.setuptools
    scprep
    sgd2
    graphtools
  ];

  doCheck = false;

}
