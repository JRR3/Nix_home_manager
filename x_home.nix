let

  pkgsLink = builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/refs/tags/23.05.tar.gz";
      };

  # cudatoolkit is broken
  config = {
    allowBroken = true;
    allowUnfree = true;
  };

  pkgs = import pkgsLink { inherit config; };
  python3 = pkgs.python310;




  altair-data-server = (
    python3.pkgs.buildPythonPackage rec {
      pname = "altair_data_server";
      version = "0.4.1";
      src = pkgs.fetchPypi {
          inherit pname version;
          sha256 = "b39205a48ab2678020fc58739cb973845879ed169cb5addddc9dcbf5a69aeb2b";
      };
      doCheck = false;
      propagatedBuildInputs = [
        pkgs.python3Packages.altair
        pkgs.python3Packages.portpicker
        pkgs.python3Packages.tornado
      ];
    }
  );

  altair-saver = (
    python3.pkgs.buildPythonPackage rec {
      pname = "altair_saver";
      version = "0.5.0";
      src = pkgs.fetchPypi {
          inherit pname version;
          sha256 = "c098bcf6868e3ba11db108904dc3b8515b54505b89bca5f69527115487b88795";
      };
      doCheck = false;
      propagatedBuildInputs = [
        altair-viewer
        selenium
      ];
    }
  );

  altair-viewer = (
    python3.pkgs.buildPythonPackage rec {
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

  anndata = (
    python3.pkgs.buildPythonPackage rec {
      pname = "anndata";
      version = "0.9.1";
      format = "pyproject";
      src = pkgs.fetchPypi {
          inherit pname version;
          sha256 = "1f28f2c427e67b0b99bdd2b281717c92a12660dfd23e0694939b6e733f0eb2c4";
      };
      doCheck = false;
      propagatedBuildInputs = [
        pkgs.python3Packages.flit-core
        pkgs.python3Packages.h5py
        pkgs.python3Packages.natsort
        pkgs.python3Packages.packaging
        pkgs.python3Packages.pandas
        pkgs.python3Packages.scipy
        pkgs.python3Packages.setuptools-scm
      ];
    }
  );

  cykhash = (
    python3.pkgs.buildPythonPackage rec {
      pname = "cykhash";
      version = "2.0.1";
      src = pkgs.fetchPypi {
          inherit pname version;
          sha256 = "b4794bc9f549114d8cf1d856d9f64e08ff5f246bf043cf369fdb414e9ceb97f7";
      };
      doCheck = false;
      propagatedBuildInputs = [
        pkgs.python3Packages.cython
      ];
    }
  );

  gtfparse = (
    python3.pkgs.buildPythonPackage rec {
      pname = "gtfparse";
      version = "2.0.1";
      src = pkgs.fetchPypi {
          inherit pname version;
          sha256 = "c45439af58cb48120910bebe4625371d8fb5735f12a749e8933c9d6f2b1a558c";
      };
      doCheck = false;
      propagatedBuildInputs = [
        pkgs.python3Packages.polars
      ];
    }
  );

  gseapy = pkgs.callPackage /home/javier/Documents/derivations/workflow/nixpkgs/gseapy.nix { };

  homer = pkgs.callPackage /home/javier/Documents/derivations/workflow/nixpkgs/homer.nix { };

  louvain = pkgs.callPackage /home/javier/Documents/derivations/workflow/nixpkgs/louvain.nix { };


  macs3 = (
    python3.pkgs.buildPythonPackage rec {
      pname = "MACS3";
      version = "3.0.0b3";
      src = pkgs.fetchPypi {
          inherit pname version;
          sha256 = "caa794d4cfcd7368447eae15878505315dac44c21546e8fecebb3561e9cee362";
      };
      doCheck = false;
      propagatedBuildInputs = [
        cykhash
        pkgs.python3Packages.hmmlearn
        pkgs.python3Packages.numpy
        #numpy
        pkgs.zlib
      ];
    }
  );

  groupies = (
    python3.pkgs.buildPythonPackage rec {
      pname = "numpy_groupies";
      version = "0.9.22";
      src = pkgs.fetchPypi {
          inherit pname version;
          sha256 = "fd50026552280ca717722f17d4231390667505bb572de564de1362b40487d34a";
      };
      doCheck = false;
      propagatedBuildInputs = [
        pkgs.python3Packages.numpy
        #numpy
        pkgs.python3Packages.toml
      ];
    }
  );

  loompy = (
    python3.pkgs.buildPythonPackage rec {
      pname = "loompy";
      version = "3.0.7";
      src = pkgs.fetchPypi {
          inherit pname version;
          sha256 = "b5cdf7b54734c6bed3a181d11947af70af2c6e0dcadc02fd0e871df232faa8f4";
      };
      doCheck = false;
      propagatedBuildInputs = [
        scanpy
        groupies
        pkgs.python3Packages.click
        pkgs.python3Packages.setuptools
      ];
    }
  );

  scvelo = (
    python3.pkgs.buildPythonPackage rec {
      pname = "scvelo";
      version = "0.2.5";
      src = pkgs.fetchPypi {
          inherit pname version;
          sha256 = "7e32d9e34245971330d69c12f4339cebe0acebb61e59a8b1aca9b369078b5207";
      };
      doCheck = false;
      propagatedBuildInputs = [
        loompy
        pkgs.python3Packages.typing-extensions
      ];
    }
  );

  pybedtools = (
    python3.pkgs.buildPythonPackage rec {
      pname = "pybedtools";
      version = "0.9.0";
      src = pkgs.fetchPypi {
          inherit pname version;
          sha256 = "9267c92cd764173449d9c31baedac0659b4eccc3d7c05e22ec378f86c0fc30a3";
      };
      doCheck = false;
      propagatedBuildInputs = [
        pkgs.python3Packages.pysam
        pkgs.python3Packages.six
        pkgs.zlib
      ];
    }
  );

  numpy = (
    python3.pkgs.buildPythonPackage rec {
      pname = "numpy";
      version = "1.23.5";
      src = pkgs.fetchPypi {
          inherit pname version;
          sha256 = "1b1766d6f397c18153d40015ddfc79ddb715cabadc04d2d228d4e5a8bc4ded1a";
      };
      doCheck = false;
      propagatedBuildInputs = [
        pkgs.python3Packages.cython
      ];
    }
  );

  qnorm = (
    python3.pkgs.buildPythonPackage rec {
      pname = "qnorm";
      version = "0.8.1";
      src = pkgs.fetchPypi {
          inherit pname version;
          sha256 = "61b2f3ef09a9c552a4f3b83dc438cb13f191fa190164361a3a508c4777eed3c7";
      };
      doCheck = false;
      propagatedBuildInputs = [
        pkgs.python3Packages.numba
        pkgs.python3Packages.numpy
        #numpy
        pkgs.python3Packages.setuptools
        pkgs.python3Packages.toml
      ];

      # Updating pyproject.toml to be compliant with setuptools>60
      preBuild = ''
        cat > pyproject.toml << EOF
        [project]
        name = "qnorm"
        version = "0.8.1"
        description = "Quantile normalization"
        authors = [
          {name = "Maarten van der Sande", email = "maartenvandersande@hotmail.com"}
        ]
        license = {text = "MIT"}

        classifiers = [
          "Development Status :: 1 - Planning",
          "Intended Audience :: Developers",
          "Intended Audience :: Science/Research",
          "License :: OSI Approved :: MIT License",
          "Operating System :: POSIX :: Linux",
          "Operating System :: MacOS :: MacOS X",
          "Programming Language :: Python",
          "Programming Language :: Python :: 3",
          "Topic :: Scientific/Engineering :: Bio-Informatics"
        ]

        dependencies = ["numba", "numpy"]
        requires-python = ">3.6"

        [metadata]
        license_files = "LICENSE"

        [build-system]
        requires = ["setuptools", "wheel", "toml"]
        build-backend = "setuptools.build_meta"

        [tool.black]
        line-length = 80

        [mypy]
        ignore_missing_imports = true
        EOF
      '';
    }
  );

  scanpy = (
    python3.pkgs.buildPythonPackage rec {
      pname = "scanpy";
      version = "1.9.3";
      format = "pyproject";
      src = pkgs.fetchPypi {
          inherit pname version;
          sha256 = "dfe65f9acd9f4c1740079a099f89fa6a44b6f0ef75ecaf85247ad4af859144d7";
      };
      doCheck = false;
      propagatedBuildInputs = [
        anndata
        pkgs.python3Packages.pygraphviz
        pkgs.python3Packages.networkx
        pkgs.python3Packages.patsy
        pkgs.python3Packages.seaborn
        session-info
        pkgs.python3Packages.statsmodels
        pkgs.python3Packages.umap-learn
      ];
    }
  );

  celltypist = (
    python3.pkgs.buildPythonPackage rec {
      pname = "celltypist";
      version = "1.6.0";
      format = "pyproject";
      src = pkgs.fetchPypi {
          inherit pname version;
          sha256 = "b158a4ff21033429519ad3b84dbc6fff0f973244ccc5f87999499e09183c1a8e";
      };
      doCheck = false;
      propagatedBuildInputs = [
        pkgs.python3Packages.annoy
        pkgs.python3Packages.openpyxl
        scglue
      ];
    }
  );

  scglue = (
    python3.pkgs.buildPythonPackage rec {
      pname = "scglue";
      version = "0.3.2";
      src = pkgs.fetchPypi {
          inherit pname version;
          sha256 = "fd57ebfa400233cbb1ab4fab4ad6a9dbf4db2c5ca715ba31c71c7a36cc931241";
      };
      doCheck = false;
      propagatedBuildInputs = [
        pkgs.python3Packages.dill
        pkgs.python3Packages.h5py
        pkgs.python3Packages.ignite
        pkgs.python3Packages.leidenalg
        pkgs.python3Packages.matplotlib
        pkgs.python3Packages.pandas
        pkgs.python3Packages.parse
        pybedtools
        pkgs.python3Packages.pynvml
        scanpy
        pkgs.python3Packages.scikit-learn
        pkgs.python3Packages.scipy
        pkgs.python3Packages.sparse
        pkgs.python3Packages.tensorboardx
      ];
    }
  );

  selenium = (
    python3.pkgs.buildPythonPackage rec {
      pname = "selenium";
      version = "4.2.0";
      format = "wheel";
      src = pkgs.fetchPypi {
          inherit pname version;
          format = "wheel";
          dist = "py3";
          python = "py3";
          platform = "any";
          sha256 = "ba5b2633f43cf6fe9d308fa4a6996e00a101ab9cb1aad6fd91ae1f3dbe57f56f";
      };
      doCheck = false;
      propagatedBuildInputs = [
        pkgs.python3Packages.certifi
        pkgs.python3Packages.pyopenssl
        pkgs.python3Packages.trio-websocket
        pkgs.python3Packages.urllib3
        urllib3-secure-extra
      ];
    }
  );

  session-info = (
    python3.pkgs.buildPythonPackage rec {
      pname = "session_info";
      version = "1.0.0";
      src = pkgs.fetchPypi {
          inherit pname version;
          sha256 = "3cda5e03cca703f32ae2eadbd6bd80b6c21442cfb60e412c21cb8ad6d5cbb6b7";
      };
      doCheck = false;
      propagatedBuildInputs = [
        pkgs.python3Packages.stdlib-list
      ];
    }
  );

  snakemake = pkgs.callPackage /home/javier/Documents/derivations/workflow/nixpkgs/snakemake.nix { };

  tssenrich = pkgs.callPackage /home/javier/Documents/derivations/workflow/nixpkgs/tssenrich.nix { };

  urllib3-secure-extra = (
    python3.pkgs.buildPythonPackage rec {
      pname = "urllib3-secure-extra";
      version = "0.1.0";
      format = "pyproject";
      src = pkgs.fetchPypi {
          inherit pname version;
          sha256 = "ee9409cbfeb4b8609047be4c32fb4317870c602767e53fd8a41005ebe6a41dff";
      };
      doCheck = false;
      propagatedBuildInputs = [
        pkgs.python3Packages.flit-core
      ];
    }
  );

  pythonDeps = pkgs.python3.withPackages (p: with p; [
    altair-saver
    fire
    gtfparse
    #gseapy
    igraph
    #leidenalg
    macs3
    matplotlib
    pybedtools
    #pyyaml
    #louvain
    #qnorm
    scanpy
    scikit-learn
    celltypist
    scglue
    scvelo
    #snakemake
    toolz
    tssenrich
    jupyter
  ]);

  externalDeps = [
    pkgs.bedtools
    pkgs.firefox
    pkgs.geckodriver
    pkgs.graphviz
    homer
    pkgs.samtools
    pkgs.discord
  ];

#PYX = [pythonDeps] ++ externalDeps;

in

{
  #PYX = [pythonDeps] ++ externalDeps;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "javier";
  # For server:
  home.homeDirectory = "/home/javier";

  # Programs
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  home.packages = [pythonDeps] ++ externalDeps;

  # Git configuration
  programs.git = {
    enable = true;
    userName = "JRR3";
    userEmail = "javier.ruizramirez@uhn.ca";
  };

  # Dotfiles
  # home.file.".spacemacs".source = ~/git_repos/dotfiles/.spacemacs;

  # Bash options
  programs.bash.enable = true;
  #programs.bash.shellAliases = { emacs = "emacs --user \"\""; };
  #programs.fish.enable = true;
  #programs.fish.shellAliases = { emacs = "emacs --user \"\""; };

  # Environmental variables
  home.sessionVariables = {
      PATH = "~/.local/bin:~/bin:$PATH";
      NIX_ENV="$NIX_PATH:$HOME/.nix-defexpr/channels";
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";

}
