# This script is for Task 3
# COMMENTS TO BE DELETED BUT READ NOW
# Since this requires specified genome range of interest,
# I thought a function would work well here
# then building a for loop inside the function 

# snp is a directory with the SNP files from the Salk Arabidopsis website
# Not added to the git for size considerations
file_function() {
    for file in snp/*.txt # will later have to be changed to data/, and this will change some of below script
    do
        num_seq=$(ls -1U snp | wc -l)
        # Counts number of files in snp directory which are the number of sequences considered
        length=$(expr $3 - $2)
        # Counts number of pairs as length of sequence
        echo "$num_seq $length" >> "$1_00$2_00$3".phy
        # Creates new file where 1 = chromosome of choice (e.g., chr1)
        # 2 = starting position, and 3 = ending position
        ref=$(find ref_genome/ -name "*$1.fas")
        ref_name=$(basename -s ".fas" "$ref")
        echo "From reference genome $ref_name"
        # to make sure base pairs are pulled from correct reference genome
        
    done
}
# Example use: file_function chr1 102 132 creates chr1_00102_00132.phy
# and echos "From reference genome TAIR10_chr1"
# Issue is only ever adds two padding 0's no matter numbers used