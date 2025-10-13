{ pkgs

, loompy
, pysam
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "velocyto";
  version = "0.17.17";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "1ad65fc53292ce1970a70bc742d73491b370038e0b0065761303e787bf7ffe39";
  };

  propagatedBuildInputs = [
    pkgs.python310Packages.click
    pkgs.python310Packages.cython_3
    loompy
    pkgs.python310Packages.matplotlib
    pysam
  ];

  doCheck = false;

}
