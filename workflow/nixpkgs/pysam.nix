{ pkgs

,
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "pysam";
  version = "0.22.0";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "ab7a46973cf0ab8c6ac327f4c3fb67698d7ccbeef8631a716898c6ba01ef3e45";
  };

  propagatedBuildInputs = [
    pkgs.bzip2
    pkgs.xz
    pkgs.zlib
  ];

  doCheck = false;

}
