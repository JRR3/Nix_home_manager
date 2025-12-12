{ pkgs

,
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "tangram-sc";
  version = "1.0.4";
  format = "pyproject";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "6ced24573e288fa01a8070e3c7600058de51296bac1702515db87c310da6ac13";
  };

  buildInputs = [
    pkgs.python310Packages.setuptools-scm
  ];

  doCheck = false;
  dontCheckRuntimeDeps = true;

}

