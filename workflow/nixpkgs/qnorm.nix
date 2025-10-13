{ pkgs

,
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "qnorm";
  version = "0.8.1";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "61b2f3ef09a9c552a4f3b83dc438cb13f191fa190164361a3a508c4777eed3c7";
  };

  propagatedBuildInputs = [
    pkgs.python310Packages.numba
    pkgs.python310Packages.toml
  ];

  doCheck = false;

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
