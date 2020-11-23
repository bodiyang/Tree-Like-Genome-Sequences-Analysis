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
215 files were downloaded.

The minimum file size was 737104 bytes.

The maximum file size was 34726050 bytes.


## Task 3

With 215 strains downloaded (i.e. 215 `quality_variant_<strain_name>.txt` files in the folder `data`), we ran `bash scripts/build_ind_genome.sh 1 997 1006`, and, in around 7 minutes, it produced `chr1_000997_to_001006.phy` in the folder `alignments`. The first line of the file is a header which gives the number of strains that were sequenced and the sequence length. Starting from the second line are each of the strains' sequences. The top of `chr1_000997_to_001006.phy` looks like this: 

    215 10
    Aa_0 ATTTGGTTAT
    Abd_0 AATTGGTTAT
    ...
    
followed by the 213 other strains' sequences.
