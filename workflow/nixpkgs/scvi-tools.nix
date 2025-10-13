{ pkgs

, anndata
, lightning
, scanpy
}:

let

  ml-collections = (
    pkgs.python310.pkgs.buildPythonPackage rec {
      pname = "ml_collections";
      version = "0.1.1";
      src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "3fefcc72ec433aa1e5d32307a3e474bbb67f405be814ea52a2166bfc9dbe68cc";
      };
      doCheck = false;
      propagatedBuildInputs = [
        pkgs.python310Packages.absl-py
        pkgs.python310Packages.contextlib2
        pkgs.python310Packages.pyyaml
      ];
    }
  );

  mudata = (
    pkgs.python310.pkgs.buildPythonPackage rec {
      pname = "mudata";
      version = "0.2.3";
      format = "pyproject";
      src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "45288ac150bfc598d68acb7c2c1c43c38c5c39522107e04f7efbf3360c7f2035";
      };
      doCheck = false;
      propagatedBuildInputs = [
        anndata
        pkgs.python310Packages.flit-core
      ];
    }
  );

  muon = (
    pkgs.python310.pkgs.buildPythonPackage rec {
      pname = "muon";
      version = "0.1.5";
      format = "pyproject";
      src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "d3a6c2c5e2f9abe9ea5c44a90812edea8838fd1ebf1420c88acbb3717a794017";
      };
      doCheck = false;
      propagatedBuildInputs = [
        mudata
        scanpy
        pkgs.python310Packages.seaborn
      ];
    }
  );



in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "scvi_tools";
  version = "1.0.4";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "a780221ea1c6201b5278a8c53df1a4679c6421aa20fdbdad9d6bedd6223b2240";
  };

  propagatedBuildInputs = [
    pkgs.python310Packages.chex
    pkgs.python310Packages.docrep
    pkgs.python310Packages.flax
    lightning
    ml-collections
    mudata
    pkgs.python310Packages.numpyro
    pkgs.python310Packages.pyro-ppl
    pkgs.python310Packages.rich
    pkgs.python310Packages.scikit-learn
    pkgs.python310Packages.sparse
    pkgs.python310Packages.xarray
  ];

  doCheck = false;

}
