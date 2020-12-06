#!/bin/bash
# this script should be run from the fp-group-2 folder as follows:
# bash calc_tree_distances.sh chr 
# where chr is the chromosome to calculate distances for. For example, for chromosome 1:
# bash calc_tree_distances.sh 1

# first input should be chromosome number
chrom_full="chr"$1
all_file_dir="treedist/"$chrom_full"-all.tre"
all_file=$chrom_full"-all.tre"

# if the file exists start by deleting it
if [[ -f $all_file_dir ]]
then
    rm $all_file_dir
fi
touch $all_file_dir

# gather each tree into 1 file, 1 tree per line
for tree in iqtree/$chrom_full*.treefile
do
    cat $tree >> $all_file_dir 
done

cd treedist

# calculate Robinson-Foulds distance for all pairs
iqtree -t $all_file -rf_all -T AUTO -pre $chrom_full"-all_pairs"

# calculate Robinson-Foulds distance for adjacent pairs
iqtree -t $all_file -rf_adj -T AUTO -pre $chrom_full"-adj_pairs"