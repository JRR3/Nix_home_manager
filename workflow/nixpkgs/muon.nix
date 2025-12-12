{ pkgs

,
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "muon";
  version = "0.1.6";
  format = "pyproject";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "762feeb6f52f865cf79d0d0332cc742fe91c1885f668ce15794b62b3952b02f9";
  };

  buildInputs = [
    pkgs.python310Packages.flit-core
  ];

  doCheck = false;
  dontCheckRuntimeDeps = true;

}
