## Scripts
This file contains the scripts necessary to evaluate the variability of the genealogical pattern across the genome.
Scripts should be run from the fp-group-2 folder, not directly from the scripts folder.
The following scripts are contained in this folder:
- `download_ref_genome.sh` downloads the reference genome
- `downloadSNP.sh` downloads SNP data from the 10001 genome project for arabidopsis plants collected from around the world
- `build_ind_genome.sh` builds individual genomes by mapping SNPs onto the reference
- `build_alignments.sh` utilizes `build_ind_genome.sh` extracts consecutive blocks of a fixed size and builds an alignment for each block, 
    then runs iqtree to get the estimated geneology of the plants from the DNA on each block
- `calc_tree_distances.sh` calculates pair-wise distances between (a) all pairs of trees and (b) trees from consecutive blocks only
- `plot_distance_distributions.r` produces plots to compare (a) the distribution of distances between random trees and the distribution of
    distances between all pairs of trees  obtained from `calc_tree_distances.sh` (a) and to compare (b) the distribution of distances between 
    consecutive trees obtained from `calc_tree_distances.sh` (b) and the distribution of distances between trees chosen randomly from the blocks 
    of the same chromosome.
- `pred_runtime.sh` is not part of the pipeline. It is a toy script to assist in calculating an estimate for the total amount of time it would take to run `build_alignments.sh` on all blocks accross all 5 chromosomes.


See the main readme or the scripts themselves for more detailed instructions of how each works.