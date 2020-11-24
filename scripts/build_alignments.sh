#!/bin/zsh


chromosome=$1
start_pos=$2
num_blocks=$3
block_size=$4

if [[ -z $chromosome ]] || [[ -z $start_pos ]] || [[ -z $num_blocks ]]
then
    echo "Missing required argument. Please call build_alignments.sh chromosome start_position num_blocks [block_size]"
    exit 1
fi

if [[ $chromosome -lt 1 ]] || [[ $chromosome -gt 5 ]] && [[ ! $chromosome == "C" ]] && [[ ! $chromosome == "M" ]]
then
    echo "invalid chromosome inputted. Must be one of 1-5,C,M."
    exit 1
fi 

if [[ -z $block_size ]] 
then
    if [[ $chromosome == "C" || $chromosome == "M" ]]
    then
        block_size=20000
    else
        block_size=100000
    fi
fi
