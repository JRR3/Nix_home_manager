{ pkgs

, scanpy
, fbpca
, geosk
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "scanorama";
  version = "1.7.4";
  format = "pyproject";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "67de100e63abc3028c7780d3a217e43e920a5781230bc6b6a51349d4605e005c";
  };

  propagatedBuildInputs = [
    scanpy
    pkgs.python310Packages.annoy
    pkgs.python310Packages.intervaltree
    fbpca
    geosk
  ];

  doCheck = false;

}
