{ pkgs

,
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "scrublet";
  version = "0.2.3";
  format = "pyproject";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "2185f63070290267f82a36e5b4cae8c321f10415d2d0c9f7e5e97b1126bf653a";
  };

  propagatedBuildInputs = [
    pkgs.python310Packages.annoy
    pkgs.python310Packages.numba
    pkgs.python310Packages.pandas
    pkgs.python310Packages.umap-learn
    pkgs.python310Packages.cython
    pkgs.python310Packages.matplotlib
    pkgs.python310Packages.scipy
    pkgs.python310Packages.scikit-learn
    pkgs.python310Packages.scikit-image
  ];

  doCheck = false;

}
