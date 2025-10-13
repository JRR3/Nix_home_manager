{ pkgs

,
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "tasklogger";
  version = "1.2.0";
  format = "pyproject";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "b0a390dbe1d4c6f7465e58ee457b5bb381657b5ede3a85bcf45199cb56ac01a4";
  };

  propagatedBuildInputs = [
    pkgs.python310Packages.setuptools
    pkgs.python310Packages.deprecated
  ];

  doCheck = false;

}
