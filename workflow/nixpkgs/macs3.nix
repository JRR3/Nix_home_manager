{ pkgs

,
}:

let

  cykhash = (
    pkgs.python310.pkgs.buildPythonPackage rec {
      pname = "cykhash";
      version = "2.0.1";
      src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "b4794bc9f549114d8cf1d856d9f64e08ff5f246bf043cf369fdb414e9ceb97f7";
      };
      doCheck = false;
      propagatedBuildInputs = [
        pkgs.python310Packages.cython_3
      ];
    }
  );

  hmmlearn = (
    pkgs.python310.pkgs.buildPythonPackage rec {
      pname = "hmmlearn";
      version = "0.3.0";
      src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "d13a91ea3695df881465e3d36132d7eef4e84d483f4ba538a4b46e24b5ea100f";
      };
      doCheck = false;
      propagatedBuildInputs = [
        pkgs.python310Packages.pybind11
        pkgs.python310Packages.scikit-learn
        pkgs.python310Packages.scipy
        pkgs.python310Packages.setuptools-scm
      ];
    }
  );



in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "MACS3";
  version = "3.0.0";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "57271e060c0f2c41f3aa6de44245c6db7fd0b1945ebfba115a6841628f75770e";
  };

  propagatedBuildInputs = [
    cykhash
    hmmlearn
    pkgs.zlib
  ];

  doCheck = false;

}
