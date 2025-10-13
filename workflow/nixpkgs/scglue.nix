{ pkgs

, anndata
, pybedtools
, scanpy
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "scglue";
  version = "0.3.2";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "fd57ebfa400233cbb1ab4fab4ad6a9dbf4db2c5ca715ba31c71c7a36cc931241";
  };

  propagatedBuildInputs = [
    anndata
    pkgs.python310Packages.dill
    pkgs.python310Packages.ignite
    pkgs.python310Packages.networkx
    pkgs.python310Packages.parse
    pybedtools
    pkgs.python310Packages.pynvml
    scanpy
    pkgs.python310Packages.seaborn
    pkgs.python310Packages.sparse
    pkgs.python310Packages.statsmodels
    pkgs.python310Packages.torch
  ];

  doCheck = false;

}
