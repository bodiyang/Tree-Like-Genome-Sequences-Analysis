# this calculates an estimate for how long it would take to build consecutive alignments and trees for all blocks on all chromosomes,
# assuming a block size of 100000 for nuclear chromosomes and 20000 for other chromosomes
# based on the runtime of 23 blocks on chromsome 1 performed across 3 computers
# no input is expected, just run 
# bash pred_runtime.sh

# count the total number of blocks across all 5 chromosomes
num_blocks=0
for tair in data/TAIR10_*.fas 
do
    numchrom=`tail -n +2 $tair | wc -m`
    if [ $tair == "data/TAIR10_chrC.fas" ] || [ $tair == "data/TAIR10_chrM.fas" ]
    then
        tmp_blocks=$(( (numchrom + 19999) / 20000 ))
        num_blocks=$(( num_blocks + tmp_blocks ))
    else
        tmp_blocks=$(( (numchrom + 99999) / 100000 ))
        num_blocks=$(( num_blocks + tmp_blocks ))
    fi
done

# print number of blocks, calculate estimated time based on 102 minutes per block runtime
echo $num_blocks " blocks total"
hours=$((($num_blocks*102)/60))
minutes=$((($num_blocks*102)-($hours*60)))
echo "At 102 minutes per block, total estimated time is "$hours " hours, " $minutes" minutes"