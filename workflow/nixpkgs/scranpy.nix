{ pkgs

,
}:

let

  assorthead = (
    pkgs.python310.pkgs.buildPythonPackage rec {
      pname = "assorthead";
      version = "0.0.11";
      src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "fa915750f29ec5f51bf2f2216e7a4c2328fd698151000cd5c37d219104a45de5";
      };
      doCheck = false;
      propagatedBuildInputs = [
      ];
    }
  );

  biocutils = (
    pkgs.python310.pkgs.buildPythonPackage rec {
      pname = "biocutils";
      version = "0.1.5";
      src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "a17de0495e18545f1a066f9a1f9c21ea2636d37666432351929b60eb9ed20aa9";
      };
      doCheck = false;
      propagatedBuildInputs = [
      ];
    }
  );

  biocframe = (
    pkgs.python310.pkgs.buildPythonPackage rec {
      pname = "BiocFrame";
      version = "0.5.9";
      src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "17a39c872d9e62855ad381b46e034cb2aa86e10f8c6f50e63e37612a5cae7c87";
      };
      doCheck = false;
      propagatedBuildInputs = [
      ];
    }
  );

  delayedarray = (
    pkgs.python310.pkgs.buildPythonPackage rec {
      pname = "DelayedArray";
      version = "0.5.0";
      src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "4843fa0805c9c3059e95e750cd43e16319ee2fff7e551cdc8fcd8c2f318e4c45";
      };
      doCheck = false;
      propagatedBuildInputs = [
      ];
    }
  );

  genomicranges = (
    pkgs.python310.pkgs.buildPythonPackage rec {
      pname = "GenomicRanges";
      version = "0.4.12";
      src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "18a26c3f443528d7801aa0f41e201788eaf848800676c8b3a0f064c56f8d2141";
      };
      doCheck = false;
      propagatedBuildInputs = [
        iranges
      ];
    }
  );

  iranges = (
    pkgs.python310.pkgs.buildPythonPackage rec {
      pname = "IRanges";
      version = "0.2.3";
      src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "cc4e010b757cd616f8e921f98254af7af577820908a8ca13fd837b438e79f1a6";
      };
      doCheck = false;
      propagatedBuildInputs = [
      ];
    }
  );

  mattress = (
    pkgs.python310.pkgs.buildPythonPackage rec {
      pname = "mattress";
      version = "0.1.6";
      src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "7e6e94ccaa23768ef43eebb6ea74496ae354739f07706b15634344b84cf3b09b";
      };
      doCheck = false;
      propagatedBuildInputs = [
        assorthead
      ];
    }
  );

  singlecellexperiment = (
    pkgs.python310.pkgs.buildPythonPackage rec {
      pname = "SingleCellExperiment";
      version = "0.4.3";
      src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "63549e81c6ecbe1b1e062232e95452f4cf4f8d2fb92a7750a169a7ed80db4bbc";
      };
      doCheck = false;
      propagatedBuildInputs = [
      ];
    }
  );

  summarizedexperiment = (
    pkgs.python310.pkgs.buildPythonPackage rec {
      pname = "SummarizedExperiment";
      version = "0.4.2";
      src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "9f2ebab982f0da1ad95f5d5983227774c9c1e9bb1fb8e1e1ff32a9653ba7a2d1";
      };
      doCheck = false;
      propagatedBuildInputs = [
        genomicranges
      ];
    }
  );



in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "scranpy";
  version = "0.1.3";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "2396ea3abbf503543262df4211becdff6a86d92fc403fda17564d6e6aa86ccff";
  };

  propagatedBuildInputs = [
    biocutils
    biocframe
    delayedarray
    pkgs.python310Packages.igraph
    mattress
    pkgs.python310Packages.numpy
    singlecellexperiment
    summarizedexperiment
  ];

  doCheck = false;

}
