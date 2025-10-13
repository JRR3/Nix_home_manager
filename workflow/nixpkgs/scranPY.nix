{ pkgs

, scanpy
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "scranPY";
  version = "1.1";

  src = pkgs.fetchFromGitHub {
    owner = "sfortma2";
    repo = "${pname}";
    rev = "v${version}";
    sha256 = "6bebe599c2010759005ce91bebb1b5705d90bd6315438e5502dda24d22dd3cb9";
  };

  propagatedBuildInputs = [
    pkgs.python310Packages.cvxpy
    scanpy
  ];

  doCheck = false;

}
