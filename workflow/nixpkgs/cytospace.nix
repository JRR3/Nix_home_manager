{ pkgs

,
}:

let

in pkgs.writeShellApplication rec {

  name = "cytospace";
  # version = "1.1.0";

  # src = pkgs.fetchFromGitHub {
  #   owner = "digitalcytometry";
  #   repo = "${pname}";
  #   rev = "v${version}";
  #   sha256 = "30f293f3bae9f46eb63b2d97b081138c50dc82e4d55279f2faf0b8926a8412b4";
  # };

  # doCheck = false;
  # dontUnpack = true;
  # dontPatchShebangs = true;
  # dontPatchELF = true;

  # installPhase = ''

  #   mkdir -p $out/src/env
  #   tar -xzf ${/mnt/data0/hoseoklee/public/cytospace_env.tar.gz} -C $out/src/env

  # '';

  runtimeInputs = [ pkgs.conda ];

  text = ''
    export var=$*
    conda-shell -c "conda activate /mnt/data0/hoseoklee/public/cytospace_env; cytospace $var"
  '';

}
