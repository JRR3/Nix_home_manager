{ pkgs

, scanpy
, schpl
, scvi-tools
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "scArches";
  version = "0.5.10";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "370fe766ac53fe60ebe420620171e05852da2e660a3fc10fc3c52d2533b59735";
  };

  propagatedBuildInputs = [
    scanpy
    schpl
    scvi-tools
  ];

  doCheck = false;

}
