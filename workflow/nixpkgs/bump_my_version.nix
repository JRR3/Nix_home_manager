{ pkgs

,
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "bump-my-version";
  version = "0.5.1";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "7562775add3219583b147df33733322c391b65c45aab203ca8ca3a35fb183b83";
  };

  propagatedBuildInputs = [
    pkgs.bump2version
  ];

  doCheck = false;

}
