#!/bin/bash
# this script should be run from the fp-group-2 folder as follows:
# bash calc_tree_distances.sh chr 
# where chr is the chromosome to calculate distances for. For example, for chromosome 1:
# bash calc_tree_distances.sh 1
# output for this script will be in the treedist directory in files named
# chrX-all.tre (all trees in one file, in the order they exist in the directory)
# chrX-all-ref.txt (list of blocks in the same order as trees in chrX-all.tre, to confirm order is correct)
# chrX-all_pairs.rfdist and chrX-adj_pairs.rfdist (distances between trees)

# first input should be chromosome number
chrom_full="chr"$1
all_file_dir="treedist/"$chrom_full"-all.tre"
all_file=$chrom_full"-all.tre"
all_ref="treedist/"$chrom_full"-all-ref.txt"

# if the file exists start by deleting it
if [[ -f $all_file_dir ]]
then
    rm $all_file_dir
fi
touch $all_file_dir
if [[ -f $all_ref ]]
then
    rm $all_ref
fi
touch $all_ref

# gather each tree into 1 file, 1 tree per line
for tree in iqtree/$chrom_full*.treefile
do
    echo $tree >> $all_ref
    cat $tree >> $all_file_dir 
done

cd treedist

# calculate Robinson-Foulds distance for all pairs
iqtree -t $all_file -rf_all -T AUTO -pre $chrom_full"-all_pairs"

# calculate Robinson-Foulds distance for adjacent pairs
iqtree -t $all_file -rf_adj -T AUTO -pre $chrom_full"-adj_pairs"