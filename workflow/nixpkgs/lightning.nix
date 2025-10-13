{ pkgs

,
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "lightning";
  version = "2.1.4";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "0e45098c700fa28c604a11ae233ce181b44aeffce2404debebc2616118431d9f";
  };

  propagatedBuildInputs = [
    pkgs.python310Packages.fsspec
    pkgs.python310Packages.lightning-utilities
    pkgs.python310Packages.setuptools
    pkgs.python310Packages.torch
    pkgs.python310Packages.torchmetrics
  ];

  doCheck = false;

}
