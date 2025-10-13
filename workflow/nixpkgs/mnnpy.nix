{ pkgs

, anndata
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "mnnpy";
  version = "0.1.6";
  #version = "0.1.7";
  format = "pyproject";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "227448615baf657253ba2d5d9f6f0ad60ff509049402739796cba8c23c961c29";
    #sha256 = "ec23872579a5358a95374a6fe87c97c9a4bf33dd01c2dd1e87ae294ff120213b";
  };

  srx = pkgs.fetchFromGitHub {
    owner = "chriscainx";
    repo = "mnnpy";
    rev = "2097dec30c193f036c5ed7e1c3d1e3a6270e102b";
    hash = "sha256-j9zpDCFDUxZfWGC2jieJpKGe8doexIphot3iN50irZI=";
  };

  propagatedBuildInputs = [
    pkgs.python310Packages.pandas
    pkgs.python310Packages.scipy
    pkgs.python310Packages.numba
    pkgs.python310Packages.cython
    anndata
  ];

  doCheck = false;

}
