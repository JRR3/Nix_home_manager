{ pkgs

, scvelo
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "velovi";
  version = "0.3.0";
  format = "pyproject";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "a6c6882061641e2698513c8bcbda4875e7c242faf11a08cd4c9559610a0f38de";
  };

  propagatedBuildInputs = [
    pkgs.python310Packages.exceptiongroup
    pkgs.python310Packages.poetry-core
    scvelo
  ];

  doCheck = false;

}
