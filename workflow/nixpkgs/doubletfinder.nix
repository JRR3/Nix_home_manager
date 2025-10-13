{ pkgs

,
}:

let

in pkgs.rPackages.buildRPackage rec {

  name = "DoubletFinder";

  src = pkgs.fetchFromGitHub {
      owner = "ekernf01";
      repo = name;
      rev = "11d1882";
      sha256 = "2e95652b82362a1e6a1123bd9594df65170354a7fba08facd104966637b0a977";
  };

  propagatedBuildInputs = [
    pkgs.rPackages.fields
    pkgs.rPackages.KernSmooth
    pkgs.rPackages.ROCR
  ];

  doCheck = false;

}