{ pkgs

,
}:

let

in pkgs.rPackages.buildRPackage rec {

  name = "seurat-disk";

  src = pkgs.fetchFromGitHub {
      owner = "mojaveazure";
      repo = name;
      rev = "877d4e1";
      sha256 = "b505deb362911c5a47f26498e0309da811f370cc74a24b7549b37a5dd2c44955";
  };

  propagatedBuildInputs = [
    pkgs.rPackages.cli
    pkgs.rPackages.crayon
    pkgs.rPackages.hdf5r
    pkgs.rPackages.Matrix
    pkgs.rPackages.R6
    pkgs.rPackages.rlang
    pkgs.rPackages.Seurat
    pkgs.rPackages.SeuratObject
    pkgs.rPackages.stringi
    pkgs.rPackages.withr
  ];

  doCheck = false;

}