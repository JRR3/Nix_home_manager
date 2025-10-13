{ pkgs

, anndata
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "anndata2ri";
  version = "1.3.2";
  format = "pyproject";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "34a767b16abfac1aacb6edcd394eaf565f53fff6de3e6f47961a3901d3890d93";
  };

  propagatedBuildInputs = [
    anndata
    pkgs.python310Packages.tzlocal
    #rpy2_hm
    pkgs.python310Packages.rpy2
  ];

  doCheck = false;

}
