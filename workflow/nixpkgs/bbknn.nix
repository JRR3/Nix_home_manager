{ pkgs

,
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "bbknn";
  version = "95ce34b8905cbde307704a77436c354938ba0367";
  format = "pyproject";

  src = pkgs.fetchFromGitHub {
    owner = "Teichlab";
    repo = "${pname}";
    rev = "${version}";
    sha256 = "sha256-6lmPaM4yNluHbM5sfBvhiVv293MDTGx745HmdmLxFfU=";
  };

  propagatedBuildInputs = [
    pkgs.python310Packages.pandas
    pkgs.python310Packages.scipy
    pkgs.python310Packages.scikit-learn
    pkgs.python310Packages.umap-learn
    pkgs.python310Packages.annoy
    pkgs.python310Packages.cython
    pkgs.python310Packages.pynndescent
    pkgs.python310Packages.flit-core
  ];

  doCheck = false;

}
