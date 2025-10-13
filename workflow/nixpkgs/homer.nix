{ pkgs

,
}:

let

in pkgs.stdenv.mkDerivation rec {
  name = "HOMER";
  version = "4.11.1";

  srcs = [
    (
      pkgs.fetchurl {
        url = "http://homer.ucsd.edu/homer/configureHomer.pl";
        sha256 = "37e36fb10387a90050251683d35fe568657941b863b2088dcb0d09d9b1b59477";
      }
    )
    (
      pkgs.fetchurl {
        url = "http://homer.ucsd.edu/homer/update.txt";
        sha256 = "9000ee528bcb458a29784872d43a6cfd22eb7fdfeb88a6fd4962998ce63dc1c1";
      }
    )
    (
      pkgs.fetchurl {
        url = "http://homer.ucsd.edu/homer/data/software/homer.v${version}.zip";
        sha256 = "80d1cd00616729894017b24a36a2ef81f9cde8bd364e875aead1e0cfb500c82b";
      }
    )

    # Genomes
    (
      pkgs.fetchurl {
        url = "http://homer.ucsd.edu/homer/data/genomes/hg38.v6.4.zip";
        sha256 = "4302dcc316f96a5d55766f7b677d89db53ae50c803e370d3a9c4185c52c270bd";
      }
    )
    (
      pkgs.fetchurl {
        url = "http://homer.ucsd.edu/homer/data/genomes/hg19.v6.4.zip";
        sha256 = "3b189dfc570c0e863b5237da34fcd354656668ebe6393c037115c3b69fbcc22b";
      }
    )
    (
      pkgs.fetchurl {
        url = "http://homer.ucsd.edu/homer/data/genomes/mm10.v6.4.zip";
        sha256 = "7cffc875f32129e6e5b6d20bdbb0da39da420de3b5ec0a2e528ac4d4c3cce297";
      }
    )
    (
      pkgs.fetchurl {
        url = "http://homer.ucsd.edu/homer/data/genomes/mm9.v6.4.zip";
        sha256 = "453329ce6fc0aec1558c1839bb9e05503c17511a0f6027ca5723dc2fb2bcaaf3";
      }
    )

    # TO ADD ADDITIONAL GENOMES
    # Copy and paste the fetchurl block and replace the url with the genome of
    # preference from update.txt and leave the sha256 hash empty. After an
    # attempt to compile the derivation, nix will provide the correct hash.
  ];

  propagatedBuildInputs = with pkgs; [
    csvkit
    perl
    toybox
    unzip
    zip
  ];

  doCheck = false;
  dontUnpack = true;

  installPhase = ''
    IFS=' ' read -r configure update archive genomes <<< $srcs

    mkdir $out

    cp $configure $out/configureHomer.pl
    cp $update $out/update.txt

    unzip -o -d $out $archive

    regex="-([a-z0-9]+?)\."
    g_list=""

    for genome in $genomes; do
      unzip -o -d $out $genome

      if [[ $genome =~ $regex ]]
      then
        # The stripping is necessary since nix attempts to recognize $ followed
        # by a set of curly brackets as an external variable
        g_list="$(echo $BASH_REMATCH | sed "s/^-\(.*\).$/\1/") $g_list"
      fi
    done

    # Install HOMER and all genomes
    perl $out/configureHomer.pl -install homer $g_list
  '';

}