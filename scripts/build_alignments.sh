#!/bin/zsh

# this script builds alignment files for consecutive blocks. 
# input should be chromsome (1-5, M, or C), start position, number of blocks, and block size
# block size is optional, 20000 will be used for chromosomes M or C by default, 100000 for chromsomes 1-5
# example:
#    bash build_alignments.sh 1 300001 8 80000
# each block is output in a file named chrX_YYYYYYYYYY_ZZZZZZZZZZ 
# where X is the chromosome, Y is the starting position of the block (padded to 10 numbers), 
# and Z is the ending position (padded to 10 zeroes)
# this script should be run from the fp-group-2 folder, not the scripts folder

# give inputs better variable names
chromosome=$1
start_pos=$2
num_blocks=$3
block_size=$4
chrom_full="chr$1" 

# check to make sure we get all the arguments we need
if [[ -z $chromosome ]] || [[ -z $start_pos ]] || [[ -z $num_blocks ]]
then
    echo "Missing required argument. Please call build_alignments.sh chromosome start_position num_blocks [block_size]"
    exit 1
fi

# check to make sure chromosome input is valid
if [[ $chromosome -lt 1 ]] || [[ $chromosome -gt 5 ]] && [[ ! $chromosome == "C" ]] && [[ ! $chromosome == "M" ]]
then
    echo "invalid chromosome inputted. Must be one of 1-5,C,M."
    exit 1
fi 

# check to make sure starting position is at the "interior" portion of the sequence
if [[ $chromosome -ge 1 ]] && [[ $chromosome -le 5 ]]
then
    if [[ $start_pos -lt 3000000 ]]
    then
        echo "starting position is in the beginning telomere."
        fi
fi 

# if we don't have a block size set to default
if [[ -z $block_size ]] 
then
    if [[ $chromosome == "C" ]] || [[ $chromosome == "M" ]]
    then
        block_size=20000
    else
        block_size=100000
    fi
fi

# get the total chromosome size to avoid errors
flnm="data/TAIR10_chr"$chromosome".fas"
chrom_size=`tail +2 $flnm | wc -m | sed -E 's/ //g'`
block_start=$start_pos

if [ -f "data/build_genome_out.txt" ]
then
    rm data/build_genome_out.txt
fi 

# loop over blocks and create output files, calling build_ind_genome.sh to build the individual block
for block in $(seq 1 $num_blocks)
do
    if [[ $block_start -gt $chrom_size ]]
    then
        break
    fi
    block_end=$((block_start + block_size - 1))
    if [[ $block_end -gt $chrom_size ]]
    then 
        block_end=$chrom_size
    fi

    
    date +"%D %T"
    echo "creating alignments for $block_start to $block_end"
    SECONDS=0
    bash scripts/build_ind_genome.sh $chromosome $block_start $block_end > data/build_genome_out.txt

    printf -v startnum "%010d" $block_start #padding with zeros
    printf -v endnum "%010d" $block_end #padding with zeros
    cd iqtree
    iqtree --no-log -djc -s ../alignments/"$chrom_full"_"$startnum"_"$endnum".phy -m HKY+G -T AUTO -pre "$chrom_full"_"$startnum"_"$endnum"
    rm ../alignments/"$chrom_full"_"$startnum"_"$endnum".phy
    cd ..
    echo "Run time "$(($SECONDS / 60))":"$(($SECONDS % 60))
    block_start=$(( block_end + 1 ))
done
