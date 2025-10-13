{ pkgs

, anndata
}:

let

  bezier = (
    pkgs.python310.pkgs.buildPythonPackage rec {
      pname = "bezier";
      version = "2023.7.28";
      src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "853256d1e1e9cd82cbb3d1543be906e9d54e8491e3020a90c084a9d18021f63b";
      };
      doCheck = false;
      propagatedBuildInputs = [
      ];

      # only installs Python extension
      BEZIER_NO_EXTENSION = true;
    }
  );



in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "celldancer";
  version = "1.1.7";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "c61021f8934fdea784d4a80deeaf0b7101e8586247808cfd44ed8b1a5083f9a7";
  };

  propagatedBuildInputs = [
    anndata
    bezier
    pkgs.python310Packages.datashader
    pkgs.python310Packages.exceptiongroup
    pkgs.python310Packages.matplotlib
    pkgs.python310Packages.pytorch-lightning
    pkgs.python310Packages.scikit-learn
    pkgs.python310Packages.seaborn
    pkgs.python310Packages.statsmodels
    pkgs.python310Packages.torch
  ];

  doCheck = false;

}
