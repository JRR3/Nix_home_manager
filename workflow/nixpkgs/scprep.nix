{ pkgs

,
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "scprep";
  version = "1.2.3";
  format = "pyproject";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "cc4ba4cedbba256935298f2ba6a973b4e74ea8cb9ad2632b693b6d4e6ab77c3f";
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
