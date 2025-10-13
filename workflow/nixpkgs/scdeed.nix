{ pkgs

,
}:

let

in pkgs.rPackages.buildRPackage rec {

  name = "scDEED";

  src = pkgs.fetchFromGitHub {
      owner = "JSB-UCLA";
      repo = name;
      rev = "1f707cc5b980ebee8be2346458494dd3775fdc4f";
      sha256 = "1dhxd1azk9r6yg2w2yhy9bg5lyjr0cjp4wmpwg0sgh17qdghzrnl";
  };

  propagatedBuildInputs = [
    #pkgs.rPackages.devtools
    pkgs.rPackages.Seurat
    pkgs.rPackages.distances
    pkgs.rPackages.foreach
    pkgs.rPackages.ggplot2
    pkgs.rPackages.pracma
    pkgs.rPackages.doParallel
    pkgs.rPackages.ggsci
    pkgs.rPackages.Rfast
    pkgs.rPackages.VGAM
    pkgs.rPackages.Matrix
  ];

  doCheck = false;

}
