{ pkgs

, Rpack
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "rpy2";
  version = "3.5.16";
  #version = "3.5.6";
  format = "pyproject";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "837e2f74583658a5c4c339761a73f9434f33ef9ced3e30c64da7562165c2801b";
    #sha256 = "3404f1031d2d8ff8a1002656ab8e394b8ac16dd34ca43af68deed102f396e771";
  };

  propagatedBuildInputs = [
    pkgs.python310Packages.cffi
    pkgs.python310Packages.jinja2
    pkgs.python310Packages.pytz
    pkgs.python310Packages.tzlocal

    pkgs.python310Packages.setuptools
    #pkgs.python310Packages.rpy2

    Rpack
  ];

  doCheck = false;

}
