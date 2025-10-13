{ pkgs

, anndata
, scanpy
, scvi-tools
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "scvelo";
  version = "0.3.1";
  format = "pyproject";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "3a41a73b29e091268c40f08dc57a63eab5dfc2bd8a57e564cf1a6aca5e4d5d22";
  };

  propagatedBuildInputs = [
    anndata
    scanpy
    scvi-tools
  ];

  doCheck = false;

}
