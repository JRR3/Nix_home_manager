{ pkgs

, pysam
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "pybedtools";
  version = "0.9.0";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "9267c92cd764173449d9c31baedac0659b4eccc3d7c05e22ec378f86c0fc30a3";
  };

  propagatedBuildInputs = [
    pysam
    pkgs.python310Packages.six
  ];

  doCheck = false;

}
