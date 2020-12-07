## Task 1
The reference genome is downloaded from ftp://ftp.arabidopsis.org/home/tair/Sequences/whole_chromosomes/ by executing the `download_ref_genome.sh` script in the `scripts/` directory, run as follows.
```
bash scripts/download_ref_genome.sh
```
The output from this script are the below TAIR10 reference genomes (with file sizes.
1. _chr1.fas: 29.4 MB
2. _chr2.fas: 19.0 MB
3. _chr3.fas: 22.7 MB
4. _chr4.fas: 17.9 MB
5. _chr5.fas: 26.1 MB
6. _chrC.fas: 153 kB
7. _chrM.fas: 363 kB

These files our output into a created `data/` directory.

## Task 2
The script `downloadSNP.sh` downloads all SNP files from the 1001 genomes project. should be run from the fp-group-2 folder. The script works with bash or zsh but zsh is preferred. Note that the script is in the `scripts/` directory, so it should be run as follows:
```
$ ./scripts/downloadSNP.sh
```
All output from the script will be in the `data/` directory. If this directory does not exist, it will be created. If it does exist, any contents beginning with   `quality_variant` will be deleted as to remove previously downloaded SNP files but not the reference genome files.

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

The script `build_ind_genome.sh` outputs a file with each strain's DNA sequence at a specified range of the genome. This script is embedded within the script for Task 4 and thus does not need to be run individually. The output file will contain a sequence for each strain with a `quality_variant_<strain_name>.txt` file downloaded in the `data` folder. The chromosome of interest and the starting and ending base positions on that chromosome are given as command line arguments. For example, the call `bash scripts/build_ind_genome.sh 1 997 1006` will generate a file called `chr1_000997_to_001006.phy` in the folder `alignments`. See [report](report.md) for details on what this file looks like.

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

For 30 blocks of size 100000 on chromosome 1:

Blocks 1-8 were started at 18:09:13 on December 1 on Evan's mac. The run finished at 11:23:21 on December 2. It took 17 hours 14 minutes and 8 seconds in total:
- Alignments 3000001 to 3100000 took 128 minutes and 22 seconds
- Alignments 3100001 to 3200000 took 166 minutes and 16 seconds
- Alignments 3200001 to 3300000 took 187 minutes and 30 seconds
- Alignments 3300001 to 3400000 took 162 minutes and 5 seconds
- Alignments 3400001 to 3500000 took 87 minutes and 5 seconds
- Alignments 3500001 to 3600000 took 89 minutes and 42 seconds
- Alignments 3600001 to 3700000 took 72 minutes and 52 seconds
- Alignments 3700001 to 3800000 took 140 minutes and 16 seconds

Blocks 9-16 were started at 22:16:06 on December 1 on Sam's mac. This run finished at 07:32:47 on December 2. It took 9 hours 16 minutes 44 seconds total.
- Alignments 3800001 to 3900000 took 71 minutes, 42 seconds
- Alignments 3900001 to 4000000 took 50 minutes, 13 seconds
- Alignments 4000001 to 4100000 took 74 minutes, 00 seconds
- Alignments 4100001 to 4200000 took 74 minutes, 22 seconds
- Alignments 4200001 to 4300000 took 74 minutes, 37 seconds
- Alignments 4300001 to 4400000 took 87 minutes, 18 seconds
- Alignments 4400001 to 4500000 took 49 minutes, 06 seconds
- Alignments 4500001 to 4600000 took 75 minutes, 23 seconds

Blocks 17-23 were started at 21:18:05 on December 2 on Bodi's mac. This run finished at 09:56:42 on December 3. It took 12 hours 38 minutes 37 seconds total.
- Alignments 4600001 to 4700000 took 88 minutes, 05 seconds
- Alignments 4700001 to 4800000 took 92 minutes, 49 seconds
- Alignments 4800001 to 4900000 took 119 minutes, 24 seconds
- Alignments 4900001 to 5000000 took 92 minutes, 05 seconds
- Alignments 5000001 to 5100000 took 87 minutes, 52 seconds
- Alignments 5100001 to 5200000 took 195 minutes, 42 seconds
- Alignments 5200001 to 5300000 took 82 minutes, 30 seconds

Blocks 24-30 were started at 18:46:51 on December 2 on Nathan's PC. This run finished at 5:20:17 on December 5. It took 2 days, 10 hours, 34 minutes and 46 seconds.
- Alignment 5300001 to 5400000 took 479 minutes, 45 seconds
- Alignment 5400001 to 5500000 took 524 minutes, 57 seconds
- Alignment 5500001 to 5600000 took 425 minutes, 17 seconds
- Alignment 5600001 to 5700000 took 790 minutes, 30 seconds
- Alignment 5700001 to 5800000 took 359 minutes, 46 seconds
- Alignment 5800001 to 5900000 took 564 minutes, 45 seconds
- Alignment 5900001 to 6000000 took 369 minutes, 46 seconds


# Task 6
The script `calc_tree_distances.sh` first gathers all trees (from files named `chrX*.treefile` in the `iqtree folder`, where X is the passed in chromosome) into a file called chrX-all.tre in the treedist folder. It then runs IQ tree to calculate Robinson-Foulds distances between
- all pairs of trees estimated 
- pairs of trees estimated from adjacent alignments of DNA
The output from this run is put into the treedist folder, as files called chrX-adj_pairs.rfdist and chrX-all_pairs.rfdist.

It is important that all test files of the form chrX*.treefile in the iqtree folder be deleted before the script is run, otherwise they will be included in the analysis. For example, the files `chr1_0030000001_0030000500.treefile`, `chr1_0030000501_0030001000.treefile`, and `chr1_0030001001_0030001500.treefile`, which are currently in the `iqtree folder`, should be deleted, before running the script.  

After deleting these test tree files, the script was run from Sam's mac as follows:
```
bash calc_tree_distances.sh 1
```

# Task 7
The script `plot_distance_distributions.R` reads in the tree distances `chr1-all_pairs.rfdist` and `chr1-adj_pairs.rfdist` from the treedist directory. 
The script creates two different histogram plots, saved as `SameChromVsRandomDistances.pdf` and `AdjVsAnyBlocksDistances.pdf` in the `plots` directory. The first plot is a comparison of the RF distances between trees estimated from different alignments of the same chromosome in each plant strain (found in Task 6) versus the RF distances between pairs of random trees, which are distributed as a linear function of a Poisson random variable. The second plot is a comparison of (a random sample of) the RF distances between all pairs of trees estimated from different alignments of the same chromosome versus only the RF distances between trees estimated from adjacent alignments of the same chromosome.

This script can be run with the command:
```
Rscript scripts/plot_distance_distributions.R
```



