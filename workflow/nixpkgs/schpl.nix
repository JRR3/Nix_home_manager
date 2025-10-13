{ pkgs

, anndata
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "scHPL";
  version = "1.0.5";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "3eb62b2e65b1faba04b7bcb86f7bf6967a6301866a605551211b8f14fd27eced";
  };

  propagatedBuildInputs = [
    anndata
    pkgs.python310Packages.newick
    pkgs.python310Packages.matplotlib
    pkgs.python310Packages.scikit-learn
    pkgs.python310Packages.seaborn
  ];

  doCheck = false;

}
