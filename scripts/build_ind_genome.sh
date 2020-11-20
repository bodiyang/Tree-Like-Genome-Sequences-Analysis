# This script is for Task 3
# COMMENTS TO BE DELETED BUT READ NOW
# Since this requires specified genome range of interest,
# I thought a function would work well here
# then building a for loop inside the function 

# snp is a directory with the SNP files from the Salk Arabidopsis website
# Not added to the git for size considerations
file_function() {
    for file in snp/*.txt
    do
        ls -1U snp | wc -l >> "$1_00$2_00$3".phy
        # Counts number of files in snp directory 
        # which are the number of sequences considered
        # Creates new file where 1 = chromosome of choice (e.g., chr1)
        # 2 = starting position, and 3 = ending position
    done
}
# Example use: file_function chr1 102 132 creates chr1_00102_00132.phy
# Issue is only ever adds two padding 0's no matter numbers used