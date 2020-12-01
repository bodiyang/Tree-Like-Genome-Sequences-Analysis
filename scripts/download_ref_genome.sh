#!/bin/zsh

# get list of files from the directory
curl "ftp://ftp.arabidopsis.org/home/tair/Sequences/whole_chromosomes/" > data/genome_directory.txt

cd data

# download each TAIR10 file from the directory
awk '{
    if (match($9,"TAIR10.*") > 0) system("curl -O ftp://ftp.arabidopsis.org/home/tair/Sequences/whole_chromosomes/"$9)
}' genome_directory.txt

rm genome_directory.txt