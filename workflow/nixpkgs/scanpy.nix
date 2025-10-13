{ pkgs

, anndata
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "scanpy";
  version = "1.9.8";
  format = "pyproject";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "2ab1790d2b82eadb0cf8d487f468beac7a8f6a3a8fd7112d1ae989f8c52a4353";
  };

  propagatedBuildInputs = [
    anndata
    pkgs.python310Packages.matplotlib
    pkgs.python310Packages.numba
    pkgs.python310Packages.umap-learn
  ];

  doCheck = false;

}
