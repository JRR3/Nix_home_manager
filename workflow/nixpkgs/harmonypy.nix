{ pkgs

,
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "harmonypy";
  version = "0.0.9";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "85bfdd4e6ec6e0fa8816a276639358d3598a40d60ba9f7a5d9dada8706be8c4d";
  };

  propagatedBuildInputs = [
    pkgs.python310Packages.pandas
    pkgs.python310Packages.scipy
    pkgs.python310Packages.scikit-learn
  ];

  doCheck = false;

}
