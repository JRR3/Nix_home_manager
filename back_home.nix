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


  bump_version = pkgs.callPackage ./workflow/nixpkgs/bump_my_version.nix { };

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

  gseapy = pkgs.callPackage ./workflow/nixpkgs/gseapy.nix { };

  harmonypy = pkgs.callPackage ./workflow/nixpkgs/harmonypy.nix { };

  homer = pkgs.callPackage ./workflow/nixpkgs/homer.nix { };

  lightning = pkgs.callPackage ./workflow/nixpkgs/lightning.nix { };

  loompy = pkgs.callPackage ./workflow/nixpkgs/loompy.nix { };

  macs3 = pkgs.callPackage ./workflow/nixpkgs/macs3.nix { };

  pybedtools = pkgs.callPackage ./workflow/nixpkgs/pybedtools.nix {
    pysam = pysam;
  };

  pysam = pkgs.callPackage ./workflow/nixpkgs/pysam.nix { };

  tmc = pkgs.callPackage ./workflow/nixpkgs/tmc.nix { };

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

  pyensembl = pkgs.callPackage ./workflow/nixpkgs/pyensembl.nix { };

  qnorm = pkgs.callPackage ./workflow/nixpkgs/qnorm.nix { };

  scanpy = pkgs.callPackage ./workflow/nixpkgs/scanpy.nix {
    anndata = anndata;
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

  pythonDeps = with pkgs; [
    ((python310.withPackages (p: with p; [

      snakemake

      # VISUALIZATION
      altair-saver
      matplotlib
      plotly
      pygraphviz

      # SINGLE-CELL ANALYSIS
      celltypist
      gseapy
      harmonypy
      pyensembl
      scanpy
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

    ])).override (args: { ignoreCollisions = true; }))
  ];

  ## Haskell
  myHaskellEnv = pkgs.haskellPackages.ghcWithPackages
                      (haskellPackages: with haskellPackages; [
                        #aeson
                        #cassava
                        #hvega
                        #hvega-theme
                        #lens
                        #lens-aeson
                        safe
                        #sparse-linear-algebra
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
    myHaskellEnv
    customR
    pkgs.samtools
    pkgs.discord
    pkgs.slack
    #pkgs.ocamlPackages.cpdf
    pkgs.conda
    pkgs.docker
    pkgs.docker-compose
    pkgs.ffmpeg_5-headless
    pkgs.tree
    #pkgs.inkscape
    pkgs.texliveFull
    pkgs.gnome.dconf-editor
    pkgs.nodePackages.prettier
    pkgs.yarn
    pkgs.gnomeExtensions.xremap
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

  #Visual Studio Code
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      vscodevim.vim
      yzhang.markdown-all-in-one
      ms-python.python
    ];
  };

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
  home.stateVersion = "23.11";

}
