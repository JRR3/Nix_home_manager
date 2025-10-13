{ pkgs

, compat
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "anndata";
  version = "0.10.5";
  format = "pyproject";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "a55fcd75c2b445ad82938ecd41de1dd4caf66547290d2423327e0e89f71bf590";
  };

  propagatedBuildInputs = [
    compat
    pkgs.python310Packages.exceptiongroup
    pkgs.python310Packages.flit-core
    pkgs.python310Packages.h5py
    pkgs.python310Packages.hatchling
    pkgs.python310Packages.hatch-vcs
    pkgs.python310Packages.natsort
    pkgs.python310Packages.packaging
    pkgs.python310Packages.pandas
    pkgs.python310Packages.scipy
    pkgs.python310Packages.setuptools-scm
  ];

  doCheck = false;

}
