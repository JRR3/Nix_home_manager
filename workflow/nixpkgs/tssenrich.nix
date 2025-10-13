{ pkgs

, pybedtools
}:

let

in pkgs.python310.pkgs.buildPythonPackage rec {

  pname = "tssenrich";
  version = "1.4.6";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "01f3b8ab7a6576e40bd2820b271fe1c041ed7fcc5b33bea8b5f8ab96675c10a2";
  };

  propagatedBuildInputs = [
    pybedtools
    pkgs.python310Packages.setuptools
  ];

  doCheck = false;

  # Rewrite the main functionality to accept BedTool objects, instead of BAM
  preBuild = ''
    cat > ./tssenrich/tssenrich.py << EOF
    #===============================================================================
    # tssenrich.py
    #===============================================================================

    """Calculate TSS enrichment for ATAC-seq data

    TODO: use BED format rather than refflat"""




    # Imports ======================================================================

    import argparse
    import gzip
    import itertools
    import math
    import os
    import os.path
    import pybedtools
    import shutil
    import subprocess
    import tempfile
    import numpy
    import sys

    from functools import partial
    from multiprocessing import Pool
    from pathlib import Path



    # Constants ====================================================================

    SAMTOOLS_PATH = os.environ.get('TSSENRICH_SAMTOOLS_PATH',
        shutil.which('samtools'))

    HG38_PATH = os.environ.get('TSSENRICH_HG38_PATH',
        os.path.join(os.path.dirname(__file__), 'hg38.bed12.bed.gz'))
    HG19_PATH = os.environ.get('TSSENRICH_HG19_PATH',
        os.path.join(os.path.dirname(__file__), 'hg19.bed12.bed.gz'))
    MM10_PATH = os.environ.get('TSSENRICH_MM10_PATH',
        os.path.join(os.path.dirname(__file__), 'mm10.bed12.bed.gz'))
    GENES_PATH = os.environ.get('TSSENRICH_GENES_PATH', HG38_PATH)

    GENOME_DICT = {'hg19': HG19_PATH, 'hg38': HG38_PATH, 'mm10': MM10_PATH}

    ENCODE_STANDARDS = """ENCODE standards:
    | Genome | Concerning | Acceptable | Ideal |
    | ------ | ---------- | ---------- | ----- |
    | hg19   | < 6        | 6 - 10     | > 10  |
    | hg38   | < 5        | 5 - 7      | > 7   |
    | mm10   | < 10       | 10 - 15    | > 15  |
    """




    # Exceptions ===================================================================

    class Error(Exception):
      """Base class for other exceptions"""

      pass


    class MissingSAMToolsError(Error):
        """Missing samtools error"""

        pass




    # Functions ====================================================================

    def generate_tss(genome=GENES_PATH):
        """A generator yielding the coordinates of transcription start sites

        Parameters
        ----------
        genome : str
            path to BED file from which to draw TSS's.

        Yields
        ------
        tuple
            the chromosome (str) and position (int) of a TSS
        """

        with gzip.open(genome, 'rt') as f:
            for line in f:
                chrom, tss_plus, tss_minus, _, _, strand, *_ = line.split()
                yield chrom, int({'+': tss_plus, '-': tss_minus}[strand])


    def generate_tss_flanks(tss, flank_distance: int = 1_000, flank_size: int = 100):
        """Generate coordinates of TSS flanks

        Parameters
        ----------
        tss
            an iterable containing coordinates of TSS's
        flank_distance : int
            distance from tss of outer ends of flanks
        flank_size : int
            size of flanks (for determining average depth)

        Yields
        ------
        tuple
            The coordinates of a TSS flank and the corresponding TSS, in the form:
            chrom, flank_start, flank_end, tss_pos
        """
        for chrom, pos in tss:
            if pos >= flank_distance:
                yield (chrom, pos - flank_distance,
                      pos - flank_distance + flank_size, pos)
                yield chrom, pos - 1, pos, pos
                yield (chrom, pos + flank_distance - flank_size,
                      pos + flank_distance, pos)


    def tss_flanks_bed_str(flanks):
        """Create a string object containing TSS flanks in BED format

        Parameters
        ----------
        flanks
            coordinates of TSS flanks

        Returns
        -------
        str
            a BED file containing TSS flanks
        """
        return '\n'.join(
            '\t'.join(str(coord) for coord in flank) for flank in flanks
        ) + '\n'


    def tss_flanks_bed_tool(genome='hg38', temp_dir=None,
        flank_distance: int = 1_000, flank_size: int = 100):
        """A BedTool representing the TSS flanks

        Parameters
        ----------
        flanks_str
            string giving input BED file
        temp_dir
            directory to use for temporary files

        Returns
        -------
        BedTool
            the TSS flanks
        """

        file_name = Path(temp_dir) / f"{genome}.bed"

        if not os.path.exists(file_name):

            if not os.path.exists(temp_dir):
                os.makedirs(temp_dir)

            flanks_str = tss_flanks_bed_str(generate_tss_flanks(
                generate_tss(genome=GENOME_DICT.get(genome, genome)),
                flank_distance=flank_distance, flank_size=flank_size))

            with open(file_name, "w") as tss_flanks:
                subprocess.Popen(
                    "bedtools sort -i - ",

                    stdin=subprocess.PIPE,
                    stdout=tss_flanks,
                    text=True, shell=True
                ).communicate(input=flanks_str)

        return file_name


    def samtools_bedcov(bed_file_path, bam_file_path, memory_gb: float = 1.0,
        threads: int = 1, mapping_quality: int = 0, flank_size: int = 100,
        samtools_path: str = SAMTOOLS_PATH, log_file_path=None, temp_dir=None):
        """Apply samtools bedcov to a bed file & a bam file

        Parameters
        ----------
        bed_file_path : str
            path to a BED file
        bam_file_path : str
            path to a BAM file
        memory_gb : float
            memory limit in gigabytes
        threads : int
            number of threads to use for sorting
        mapping_quality : int
            ignore reads with mapping quality below this value [0]
        flank_size : int
            size of flanks (for determining average depth)
        samtools_path : str
            path to the samtools executable
        log_file_path
            path to a log file
        temp_dir
            directory to use for temporary files

        Returns
        -------
        bytes
            the output of samtools bedcov
        """

        if not samtools_path:
            raise MissingSAMToolsError(
                """samtools was not found! Please provide the `samtools_path`
                parameter, or set the `SAMTOOLS_PATH` environment variable, or make
                sure `samtools` is installed and can be found via the `PATH`
                environment variable.
                """
            )

        return subprocess.Popen(
            (
                "bedtools sort -i - | "
                f"bedtools coverage -sorted -a {bed_file_path} -b -"
            ),

            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            text=True, shell=True
        ).communicate(input=bam_file_path)[0]


    def generate_coverage_values(bedcov):
        """Generate coverage values from the output of samtools bedcov

        Parameters
        ----------
        bedcov : BedTool
            output from bedtools coverage

        Yields
        ------
        tuple
            (tss_center_depth, flank_depth) per TSS
        """

        for _, intervals in itertools.groupby(
            sorted(((chrom, int(start), int(end), int(tss), int(cov))
                    for chrom, start, end, tss, _, cov, *_ in [
                        index.split("\t")
                        for index in bedcov.splitlines()
                    ]),
                key=lambda interval: (interval[0], interval[3])),
            key=lambda interval: (interval[0], interval[3])
        ):
            if not intervals:
                continue

            lower_flank_cov, tss_cov, upper_flank_cov = (
                interval[4] for interval in sorted(set(intervals)))
            yield tss_cov, (lower_flank_cov + upper_flank_cov) / 200


    def calculate_enrichment(coverage_values):
        """Calculate TSS enrichment value for a dataset

        Parameters
        ----------
        coverage_values
            iterable of tuples (tss_center_depth, flank_depth) per TSS

        Returns
        -------
        float
            the TSS enrichment value
        """

        tss_depth, flank_depth = (sum(z) for z in zip(*coverage_values))

        try:
            return tss_depth / flank_depth
        except ZeroDivisionError:
            return numpy.nan


    def tss_enrichment(bam_file_path, genome='hg38', memory_gb: float = 1.0,
        threads: int = 1, mapping_quality: int = 0,
        samtools_path: str = SAMTOOLS_PATH, log_file_path=None, temp_dir=None,
        flank_distance: int = 1_000, flank_size: int = 100):
        """Calculate TSS enrichment from ATAC-seq data

        Parameters
        ----------
        bam_file_path : BedTool
            BedTool object
        genome : str
            genome build to use (must be 'hg38' or 'hg19') [hg38]
        memory_gb : float
            memory limit in gigabytes [1.0]
        threads : int
            number of threads to use for sorting [1]
        mapping_quality : int
            ignore reads with mapping quality below this value [0]
        samtools_path : str
            path to the samtools executable
        log_file_path
            path to a log file

        Returns
        -------
        float
            the TSS enrichment value
        """

        tss_flanks = tss_flanks_bed_tool(genome=genome, temp_dir=temp_dir,
            flank_distance=flank_distance, flank_size=flank_size)

        return calculate_enrichment(generate_coverage_values(samtools_bedcov(
            tss_flanks, bam_file_path, memory_gb=memory_gb, threads=threads,
            mapping_quality=mapping_quality, samtools_path=samtools_path,
            log_file_path=log_file_path, temp_dir=temp_dir)))


    def parse_arguments():
        parser = argparse.ArgumentParser(
            description='calculate TSS enrichment for ATAC-seq data',
            epilog=ENCODE_STANDARDS, formatter_class=argparse.RawTextHelpFormatter)
        parser.add_argument('bam', metavar='<path/to/file.bam>', nargs='+',
            help='Path to input BAM file')
        parser.add_argument('--genome', metavar='{hg38,hg19,mm10,</path/to/file.bed.gz>}',
            default='hg38', help='genome build or path to BED file [hg38]')
        parser.add_argument('--names', action='store_true',
            help='include sample names in output')
        parser.add_argument('--memory', metavar='<float>', type=float, default=1.0,
            help='memory limit in GB [2]')
        parser.add_argument('--processes', metavar='<int>', type=int, default=1,
            help='number of processes/threads to use [1]')
        parser.add_argument('--mapping-quality', metavar='<int>', type=int,
            default=0,
            help='ignore reads with mapping quality below the given value [0]')
        parser.add_argument('--samtools-path', metavar='<path/to/samtools>',
            default=SAMTOOLS_PATH,
            help=f'path to an alternate samtools executable [{SAMTOOLS_PATH}]')
        parser.add_argument('--log', metavar='<path/to/log.txt>',
            help='path to log file')
        parser.add_argument('--tmp-dir',metavar='<temp/file/dir/>',
            help='directory to use for temporary files')
        parser.add_argument('--flank-distance', metavar='<int>', default=1_000,
            help='distance from tss of outer ends of flanks [1000]')
        parser.add_argument('--flank-size', metavar='<int>', default=100,
            help='size of flanks (for determining average depth) [100]')
        return parser.parse_args()


    def main():
        args = parse_arguments()
        n_bam = len(args.bam)
        with Pool(processes=min(args.processes, n_bam)) as pool:
            values = pool.map(
                partial(
                    tss_enrichment,
                    genome=GENOME_DICT.get(args.genome, args.genome),
                    memory_gb=args.memory / n_bam,
                    threads=max(1, math.floor(args.processes / n_bam)),
                    mapping_quality=args.mapping_quality,
                    samtools_path=args.samtools_path,
                    log_file_path=args.log,
                    temp_dir=args.tmp_dir,
                    flank_distance=args.flank_distance,
                    flank_size=args.flank_size
                ),
                args.bam
            )
        for bam, value in zip(args.bam, values):
            if args.names:
                print(f'{os.path.basename(bam)[:-4]}\t{value}')
            else:
                print(value)
  '';

}