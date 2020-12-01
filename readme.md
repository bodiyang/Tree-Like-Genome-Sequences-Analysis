See:
- [overview](overview.md) of the project: learning goals,
  group work, and overview of tasks and pipeline
- [step by step](stepsinstructions.md) instructions.

Now delete these lines and replace by your own "readme"
to document your pipeline.
Your result summary should go in a different markdown file,
`report.md`.

## Task 1
TAIR10 Reference genome file sizes are as follows.
1. _chr1.fas: 29.4 MB
2. _chr2.fas: 19.0 MB
3. _chr3.fas: 22.7 MB
4. _chr4.fas: 17.9 MB
5. _chr5.fas: 26.1 MB
6. _chrC.fas: 153 kB
7. _chrM.fas: 363 kB

## Task 2
The script `downloadSNP.sh` downloads all SNP files from the 1001 genomes project. should be run from the fp-group-2 folder. The script works with bash or zsh but zsh is preferred. Note that the script is in the `scripts/` directory, so it should be run as follows:
```
$ ./scripts/downloadSNP.sh
```
All output from the script will be in the `data/` directory. If this directory does not exist, it will be created. If it does exist, its contents will be deleted.
Output includes: 
 - All downloaded files, `filenames.txt` which is a list of all files which were attempted to be downloaded
 - log.txt, the output of the curl commmand used to download the files
 - summary.txt, which contains the number of files downloaded, the minimum file size, and the maximum file size

The script works as follows:
1. The list of files to be downloaded is obtained by querying http://signal.salk.edu/atg1001/download.php
2. Each of these files is downloaded from http://signal.salk.edu/atg1001/data/Salk/quality_variant_[FILENAME].txt and stored in the `data/` directory
3. The file size is calculated for each file and the minimum and maximum sizes are outputted to summary.txt, along with the number of files. 

The script took about 53 minutes to run, and downloaded 215 SNP files

## Task 3

The script `build_ind_genome.sh` outputs a file with each strain's DNA sequence at a specified range of the genome. The output file will contain a sequence for each strain with a `quality_variant_<strain_name>.txt` file downloaded in the `data` folder. The chromosome of interest and the starting and ending base positions on that chromosome are given as command line arguments. For example, the call `bash scripts/build_ind_genome.sh 1 997 1006` will generate a file called `chr1_000997_to_001006.phy` in the folder `alignments`. See [report](report.md) for details on what this file looks like.

## Task 4
The script `build_alignments.sh` extracts consecutive and non-overlapping alignments (blocks) of a fixed length from a chosen chromosome. The script takes three arguments: chromosome (i.e., 1-5, C, M); starting position (with a starting index of 1); and number of blocks to produce. There is also a fourth optional argument: block size. For this optional argument, the default is 20,000 base pairs for the C and M chromosomes, and 100,000 base pairs for chromosomes 1-5.
(The script will run a check of the arguments, to make sure the chromosome's name is in the correct format, starting position does not exceed the length of the chromosome). For Tasks 4-7, we've restricted our analysis to Chromosome 1. 

Sample alignment files produced by the following command are included in the github repository
```
bash scripts/build_alignments.sh 1 30000001 3 500
```

## Task 5
The script `build_alignments.sh` also takes care of producing trees for each block using iqtree. 
Again, samples trees produced by the following command are included in the github repository
```
bash scripts/build_alignments.sh 1 30000001 3 500
```