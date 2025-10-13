{ pkgs

, tasklogger
, pygsp
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "graphtools";
  version = "1.5.3";
  format = "pyproject";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "b35ae2974d24c507fe01b110d10b1d8c949e20bc49ff9d7d04f94849f9795907";
  };

  propagatedBuildInputs = [
    #pkgs.python310Packages.setuptools
    tasklogger
    pygsp
    pkgs.python310Packages.numpy
    pkgs.python310Packages.scipy
    pkgs.python310Packages.umap-learn
  ];

  doCheck = false;

}
