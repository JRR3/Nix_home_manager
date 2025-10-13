{ pkgs

,
}:

let

  numpy-groupies = (
    pkgs.python310.pkgs.buildPythonPackage rec {
      pname = "numpy-groupies";
      version = "0.10.2";
      format = "pyproject";
      src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "f920c4ded899f5975d94fc63d634e7c89622056bbab8cc98a44d4320a0ae8a12";
      };
      doCheck = false;
      propagatedBuildInputs = [
        pkgs.python310Packages.numpy
        pkgs.python310Packages.setuptools
        pkgs.python310Packages.setuptools-scm
      ];
    }
  );



in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "loompy";
  version = "3.0.7";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "b5cdf7b54734c6bed3a181d11947af70af2c6e0dcadc02fd0e871df232faa8f4";
  };

  propagatedBuildInputs = [
    pkgs.python310Packages.h5py
    pkgs.python310Packages.numba
    numpy-groupies
    pkgs.python310Packages.scikit-learn
  ];

  doCheck = false;

}
