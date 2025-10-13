{ pkgs

,
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "toomanycells";
  version = "1.0.69";
  format = "pyproject";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "13e5646c7db334a50de51e6f6f643a8ff9f13463b5c8c626a6260810a0fe716f";
  };

  propagatedBuildInputs = [
    pkgs.python310Packages.setuptools-scm
  ];

  doCheck = false;

}
