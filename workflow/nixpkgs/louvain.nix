{ pkgs

,
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "louvain";
  version = "0.8.1";

  vendor = "igraph";
  vversion = "0.10.4";

  srcs = [
    (
      pkgs.fetchPypi {
        inherit pname version;
        sha256 = "b4df2cb8e46d5df7d1579cbcf9430b76d32dc88f58b854e566e11f9c10ac28f5";
      }
    )
    (
      pkgs.fetchurl {
        url = "https://github.com/${vendor}/${vendor}/releases/download/${vversion}/${vendor}-${vversion}.tar.gz";
        sha256 = "aa5700b58c5f1e1de1f4637ab14df15c6b20e25e51d0f5a260921818e8f02afc";
      }
    )
  ];

  sourceRoot = "${pname}-${version}";

  nativeBuildInputs = [
    pkgs.cmake
  ];

  propagatedBuildInputs = [
    pkgs.python310Packages.igraph
    pkgs.python310Packages.setuptools-scm
  ];

  # Adding in missing files and directories to by-pass installation
  configurePhase = ''
    IFS=' ' read -r louvain igraph <<< $srcs

    # # Replace igraph with the newest version
    # rm -rf ./vendor/source/igraph
    # tar -xf $igraph ${vendor}-${vversion}
    # mv ${vendor}-${vversion} vendor/source/igraph
    # ls vendor/source/igraph

    touch CMakeLists.txt
  '';

  doCheck = false;

}