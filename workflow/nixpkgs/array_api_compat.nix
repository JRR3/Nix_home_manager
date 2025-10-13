{ pkgs

,
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "array_api_compat";
  version = "1.4.1";
  format = "pyproject";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "053103b7c0ba73626bff7380abf27a29dc80de144394137bc7455b7eba23d8c0";
  };

  propagatedBuildInputs = [
    pkgs.python310Packages.setuptools
  ];

  doCheck = false;

}
