{ pkgs

, scanpy
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "celltypist";
  version = "1.6.2";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "a22309230c578c3738f72643492387167053f35a610625c75d66b056cf520361";
  };

  propagatedBuildInputs = [
    pkgs.python310Packages.requests
    scanpy
  ];

  doCheck = false;

}
