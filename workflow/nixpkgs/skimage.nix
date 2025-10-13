{ pkgs

,
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "scikit_image";
  version = "0.23.2";
  format = "pyproject";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "c9da4b2c3117e3e30364a3d14496ee5c72b09eb1a4ab1292b302416faa360590";
  };

  propagatedBuildInputs = [
    pkgs.python310Packages.umap-learn
  ];

  doCheck = false;

}
