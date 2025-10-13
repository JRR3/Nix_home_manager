{ pkgs

,
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "vl_convert_python";
  version = "1.7.0";
  format = "wheel";

  src = pkgs.fetchPypi {
    inherit pname version format;
    dist = "cp37";
    python = "cp37";
    abi = "abi3";
    platform = "manylinux_2_17_x86_64.manylinux2014_x86_64";
    sha256 = "8b50c492b640abb89a54a71e2c26f0f2d2c1cedc42030cc55bcc202670334724";
  };

  buildInputs = [
  ];

  doCheck = false;
  dontCheckRuntimeDeps = true;

}
