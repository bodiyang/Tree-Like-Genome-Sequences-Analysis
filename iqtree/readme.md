## Tree files

This folder contains the phylogenic trees estimated from each of 30 different DNA blocks from chromosome 1. The names of the files indicate which block of DNA the tree was estimated from.

- The files with extension .treefile give the "parenthetical description" of the tree (one line of text with numbers giving branch lengths). 
- The files with extension .iqtree contain a visualization of the tree

This folder also contains a few test file trees that were created to test `build_alignments.sh`. The test files that begin with "chr1" should be removed before running `calc_tree_distances.sh`--otherwise, they will be included in the analysis.
