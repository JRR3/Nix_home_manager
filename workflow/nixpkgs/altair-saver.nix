{ pkgs

,
}:

let

  altair-data-server = (
    pkgs.python310.pkgs.buildPythonPackage rec {
      pname = "altair_data_server";
      version = "0.4.1";
      src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "b39205a48ab2678020fc58739cb973845879ed169cb5addddc9dcbf5a69aeb2b";
      };
      doCheck = false;
      propagatedBuildInputs = [
        pkgs.python310Packages.altair
        pkgs.python310Packages.portpicker
        pkgs.python310Packages.tornado
      ];
    }
  );

  altair-viewer = (
    pkgs.python310.pkgs.buildPythonPackage rec {
      pname = "altair_viewer";
      version = "0.4.0";
      src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "f5d33df775cb9094544f15e9b5788224488f506cf546c708980d2d44c2f93534";
      };
      doCheck = false;
      propagatedBuildInputs = [
        altair-data-server
      ];
    }
  );

  selenium = (
    pkgs.python310.pkgs.buildPythonPackage rec {
      pname = "selenium";
      version = "4.17.2";
      src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "d43d6972e516855fb242ef9ce4ce759057b115070e702e7b1c1032fe7b38d87b";
      };
      doCheck = false;
      propagatedBuildInputs = [
        pkgs.python310Packages.certifi
        pkgs.python310Packages.pyopenssl
        pkgs.python310Packages.trio-websocket
        pkgs.python310Packages.urllib3
        urllib3-secure-extra
      ];
    }
  );

  urllib3-secure-extra = (
    pkgs.python310.pkgs.buildPythonPackage rec {
      pname = "urllib3-secure-extra";
      version = "0.1.0";
      format = "pyproject";
      src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "ee9409cbfeb4b8609047be4c32fb4317870c602767e53fd8a41005ebe6a41dff";
      };
      doCheck = false;
      propagatedBuildInputs = [
        pkgs.python310Packages.flit-core
      ];
    }
  );



in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "altair_saver";
  version = "0.5.0";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "c098bcf6868e3ba11db108904dc3b8515b54505b89bca5f69527115487b88795";
  };

  propagatedBuildInputs = [
    altair-viewer
    selenium
  ];

  doCheck = false;

}
