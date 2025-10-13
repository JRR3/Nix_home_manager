let

  pkgsLink = builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/refs/tags/23.11.tar.gz";
      };

  # cudatoolkit is broken
  config = {
    allowBroken = true;
    allowUnfree = true;
  };

  pkgs = import pkgsLink { inherit config; };

  altair-saver = pkgs.callPackage ./workflow/nixpkgs/altair-saver.nix { };

  compat = pkgs.callPackage ./workflow/nixpkgs/array_api_compat.nix { };

  anndata = pkgs.callPackage ./workflow/nixpkgs/anndata.nix { 
    compat = compat;
  };

  celldancer = pkgs.callPackage ./workflow/nixpkgs/celldancer.nix {
    anndata = anndata;
  };

  celltypist = pkgs.callPackage ./workflow/nixpkgs/celltypist.nix {
    scanpy = scanpy;
  };

  DoubletFinder = pkgs.callPackage ./workflow/nixpkgs/doubletfinder.nix { };

  scdeed = pkgs.callPackage ./workflow/nixpkgs/scdeed.nix { };
  
  gseapy = pkgs.callPackage ./workflow/nixpkgs/gseapy.nix { };

  harmonypy = pkgs.callPackage ./workflow/nixpkgs/harmonypy.nix { };

  bbknn = pkgs.callPackage ./workflow/nixpkgs/bbknn.nix { };

  mnnpy = pkgs.callPackage ./workflow/nixpkgs/mnnpy.nix {
    anndata = anndata;
  };

  homer = pkgs.callPackage ./workflow/nixpkgs/homer.nix { };

  lightning = pkgs.callPackage ./workflow/nixpkgs/lightning.nix { };

  loompy = pkgs.callPackage ./workflow/nixpkgs/loompy.nix { };

  macs3 = pkgs.callPackage ./workflow/nixpkgs/macs3.nix { };

  pybedtools = pkgs.callPackage ./workflow/nixpkgs/pybedtools.nix {
    pysam = pysam;
  };

  pysam = pkgs.callPackage ./workflow/nixpkgs/pysam.nix { };

  pyensembl = pkgs.callPackage ./workflow/nixpkgs/pyensembl.nix { };

  qnorm = pkgs.callPackage ./workflow/nixpkgs/qnorm.nix { };

  scanpy = pkgs.callPackage ./workflow/nixpkgs/scanpy.nix {
    anndata = anndata;
  };

  ann2R = pkgs.callPackage ./workflow/nixpkgs/anndata2ri.nix {
    anndata = anndata;
  };


  bump_version = pkgs.callPackage ./workflow/nixpkgs/bump_my_version.nix { };

  #stp = pkgs.callPackage ./workflow/nixpkgs/stptools_scm.nix { };
  tmc = pkgs.callPackage ./workflow/nixpkgs/tmc.nix { };

  #skimage = pkgs.callPackage ./workflow/nixpkgs/skimage.nix { };
  scrub = pkgs.callPackage ./workflow/nixpkgs/scrub.nix { };

  fbpca = pkgs.callPackage ./workflow/nixpkgs/fbpca.nix { };
  geosk = pkgs.callPackage ./workflow/nixpkgs/geosketch.nix { };
  scanorama = pkgs.callPackage ./workflow/nixpkgs/scanorama.nix {
    scanpy = scanpy;
    fbpca = fbpca;
    geosk = geosk;
  };

  scprep = pkgs.callPackage ./workflow/nixpkgs/scprep.nix { };
  sgd2 = pkgs.callPackage ./workflow/nixpkgs/sgd2.nix { };
  tasklogger = pkgs.callPackage ./workflow/nixpkgs/tasklogger.nix { };
  pygsp = pkgs.callPackage ./workflow/nixpkgs/pygsp.nix { };
  graphtools = pkgs.callPackage ./workflow/nixpkgs/graphtools.nix {
    tasklogger = tasklogger;
    pygsp = pygsp;
  };
  phate = pkgs.callPackage ./workflow/nixpkgs/phate.nix {
    graphtools = graphtools;
    scprep = scprep;
    sgd2 = sgd2;
  };

  scarches = pkgs.callPackage ./workflow/nixpkgs/scarches.nix {
    scanpy = scanpy;
    schpl = schpl;
    scvi-tools = scvi-tools;
  };

  scglue = pkgs.callPackage ./workflow/nixpkgs/scglue.nix {
    anndata = anndata;
    pybedtools = pybedtools;
    scanpy = scanpy;
  };

  schpl = pkgs.callPackage ./workflow/nixpkgs/schpl.nix {
    anndata = anndata;
  };

  scranpy = pkgs.callPackage ./workflow/nixpkgs/scranpy.nix { };

  scranPY = pkgs.callPackage ./workflow/nixpkgs/scranPY.nix {
    scanpy = scanpy;
  };

  scvelo = pkgs.callPackage ./workflow/nixpkgs/scvelo.nix {
    anndata = anndata;
    scanpy = scanpy;
    scvi-tools = scvi-tools;
  };

  scvi-tools = pkgs.callPackage ./workflow/nixpkgs/scvi-tools.nix {
    anndata = anndata;
    lightning = lightning;
    scanpy = scanpy;
  };

  snakemake = pkgs.callPackage ./workflow/nixpkgs/snakemake.nix { };

  tssenrich = pkgs.callPackage ./workflow/nixpkgs/tssenrich.nix {
    pybedtools = pybedtools;
  };

  velocyto = pkgs.callPackage ./workflow/nixpkgs/velocyto.nix {
    loompy = loompy;
    pysam = pysam;
  };

  velovi = pkgs.callPackage ./workflow/nixpkgs/velovi.nix {
    scvelo = scvelo;
  };

  vl_convert = pkgs.callPackage ./workflow/nixpkgs/vl-convert-python.nix {};


  pythonDeps = with pkgs; [
    ((python310.withPackages (p: with p; [

      snakemake

      # VISUALIZATION
      altair-saver
      matplotlib
      plotly
      cairosvg
      vl_convert

      # SINGLE-CELL ANALYSIS
      celltypist
      gseapy
      harmonypy
      bbknn
      mnnpy
      pyensembl
      scanpy
      scrub
      scanorama
      scarches
      schpl
      scglue
      scranpy
      scranPY
      scvi-tools
      tssenrich

      # RNA VELOCITY
      celldancer
      scvelo
      velocyto
      velovi

      # GENERAL
      anndata
      fire
      jupyter
      leidenalg
      loompy
      macs3
      pybedtools
      pygraphviz
      pydot
      pysam
      tmc
      phate
      qnorm
      scikit-learn
      scikit-misc
      cookiecutter
      bump_version
      rich-click
      pydantic
      tomlkit
      nix-prefetch-github
      ann2R
      nltk
      gensim
      pytest
      pip
      rdkit
      pillow
      hdbscan
      dataset
      opencv4

    ])).override (args: { ignoreCollisions = true; }))
  ];

  ## Haskell
  myHaskellEnv = pkgs.haskellPackages.ghcWithPackages
                      (haskellPackages: with haskellPackages; [
                        aeson
                        cassava
                        hvega
                        hvega-theme
                        lens
                        lens-aeson
                        safe
                        sparse-linear-algebra
                        turtle
                      ]);

  pkgsLink_new = builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/refs/tags/24.05.tar.gz";
      };
  pkgs_new = import pkgsLink_new { inherit config; };

  seuratdisk = pkgs_new.callPackage ./workflow/nixpkgs/seuratdisk.nix { };

  customR = pkgs_new.rWrapper.override {
    packages = with pkgs_new.rPackages; [

      anndata
      dplyr
      DropletUtils
      # loomr
      readr
      # SCP
      Seurat
      tidyverse
      zellkonverter
      seuratdisk
      #scdeed
      resample

    ];
  };

  externalDeps = [
    pkgs.bedtools
    pkgs.firefox
    pkgs.geckodriver
    pkgs.graphviz
    homer
    #myHaskellEnv
    pkgs.samtools
    #pkgs.discord
    #pkgs.slack
    #pkgs.ocamlPackages.cpdf
    pkgs.conda
    pkgs.docker
    pkgs.docker-compose
    pkgs.ffmpeg_5-headless
    pkgs.glibc
    pkgs.libstdcxx5
    pkgs.pciutils
    pkgs.aria2
    customR

  ];



in

{

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

  home.packages = pythonDeps ++ externalDeps;

  ##Visual Studio Code
  #programs.vscode = {
    #enable = true;
    #extensions = with pkgs.vscode-extensions; [
      #dracula-theme.theme-dracula
      #vscodevim.vim
      #yzhang.markdown-all-in-one
      #ms-python.python
    #];
  #};

  # Git configuration
  programs.git = {
    enable = true;
    userName = "JRR3";
    userEmail = "javier.ruizramirez@uhn.ca";
    extraConfig = {
        core.editor = "vim";
    };
  };

  programs.vim.defaultEditor = true;

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

  imports = [
    "${fetchTarball "https://github.com/msteen/nixos-vscode-server/tarball/master"}/modules/vscode-server/home.nix"
  ];
  services.vscode-server.enable=true;

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
