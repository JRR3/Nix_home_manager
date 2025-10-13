{ pkgs

,
}:

let

  datacache = (
    pkgs.python310.pkgs.buildPythonPackage rec {
      pname = "datacache";
      version = "1.4.0";
      src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "d00c3bdff28fa87e640b0d321fd07999c70ea6d5854c9689fc8022ea15ff650a";
      };
      doCheck = false;
      propagatedBuildInputs = [
        pkgs.python310Packages.appdirs
        pkgs.python310Packages.pandas
        pkgs.python310Packages.requests
        pkgs.python310Packages.typechecks
      ];
    }
  );

  gtfparse = (
    pkgs.python310.pkgs.buildPythonPackage rec {
      pname = "gtfparse";
      version = "2.0.1";
      src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "c45439af58cb48120910bebe4625371d8fb5735f12a749e8933c9d6f2b1a558c";
      };
      doCheck = false;
      propagatedBuildInputs = [
        pkgs.python310Packages.pandas
        pkgs.python310Packages.polars
      ];
    }
  );

  memoized-property = (
    pkgs.python310.pkgs.buildPythonPackage rec {
      pname = "memoized-property";
      version = "1.0.3";
      src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "4be4d0209944b9b9b678dae9d7e312249fe2e6fb8bdc9bdaa1da4de324f0fcf5";
      };
      doCheck = false;
      propagatedBuildInputs = [
      ];
    }
  );



in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "pyensembl";
  version = "2.3.9";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "444c4f489818fd639c34a631a9527cd6bb6586bf20b58daffe1b79d1d1ef86f4";
  };

  propagatedBuildInputs = [
    datacache
    gtfparse
    memoized-property
    pkgs.python310Packages.serializable
    pkgs.python310Packages.setuptools
  ];

  doCheck = false;

}
