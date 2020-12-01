#!/bin/zsh

# give inputs better variable names
chromosome=$1
start_pos=$2
num_blocks=$3
block_size=$4

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
    block_end=$((block_start + block_size))
    if [[ $block_end -gt $chrom_size ]]
    then 
        block_end=$chrom_size
    fi

    date +"%D %T"
    echo "creating alignments for "$block_start" to "$block_end
    SECONDS=0
    bash scripts/build_ind_genome.sh $chromosome $block_start $block_end >> data/build_genome_out.txt
    echo "Run time "$(($SECONDS / 60))":"$(($SECONDS % 60))

    printf -v startnum "%06d" $start_pos #padding with zeros
    printf -v endnum "%06d" $end_pos #padding with zeros
    cd iqtree
    iqtree --no-log -djc -s ../alignments/"$chromosome"_"$startnum"_"$endnum".phy -m HKY+G -T AUTO -pre "$chromosome"_"$startnum"_"$endnum"
    rm ../alignments/"$chromosome"_"$startnum"_"$endnum".phy
    cd ..
    (( block_start += block_size ))
done
