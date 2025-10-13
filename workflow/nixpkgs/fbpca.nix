{ pkgs

,
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "fbpca";
  version = "1.0";
  format = "pyproject";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "150677642479663f317fdbb5e06dab3f98721cf7031bb4a84113d7a631c472d1";
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
