{ pkgs

,
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "s_gd2";
  version = "1.8.1";
  format = "pyproject";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "977597da6d7f6f4b7a479732e374e48d34369e047090720c5d78ca3ca59dc269";
  };

  propagatedBuildInputs = [
    pkgs.python310Packages.setuptools
    pkgs.python310Packages.numpy
    pkgs.python310Packages.cython
  ];

  doCheck = false;

}
