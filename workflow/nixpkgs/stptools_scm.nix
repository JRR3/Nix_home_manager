{ pkgs

,
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "setuptools_scm";
  version = "8.1.0";
  format = "pyproject";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "42dea1b65771cba93b7a515d65a65d8246e560768a66b9106a592c8e7f26c8a7";
  };

  propagatedBuildInputs = [
    pkgs.python310Packages.tomli
    pkgs.python310Packages.setuptools
  ];

  doCheck = false;

}
