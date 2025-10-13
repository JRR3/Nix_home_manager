{ pkgs

,
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "geosketch";
  version = "1.2";
  format = "pyproject";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "bbfe97366b91c5927b6076d5a6738d9cfbe094efb5ac1117aab7a30b6081cc4e";
  };

  propagatedBuildInputs = [
    #stp
    #pkgs.xz
    #pkgs.zlib
    #pkgs.python310Packages.toml
    pkgs.python310Packages.setuptools
  ];

  doCheck = false;

}
