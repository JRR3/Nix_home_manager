{ pkgs

,
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "PyGSP";
  version = "0.5.1";
  format = "pyproject";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "4874ad88793d622d4f578b40c6617a99b1f02bc6c6c4077f0e48cd71c7275800";
  };

  propagatedBuildInputs = [
    pkgs.python310Packages.setuptools
    pkgs.python310Packages.numpy
    pkgs.python310Packages.scipy
  ];

  doCheck = false;

}
