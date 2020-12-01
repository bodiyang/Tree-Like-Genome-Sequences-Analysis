#Chromosome, starting, and ending positions are given as command line arguments.
#Chromosome given as number 1 through 5, C or M.
#Example call: "bash scripts/build_ind_genome.sh C 1568 1892"
#Let's start by assigning these command line arguments to new variable names


chrom_full="chr$1" 
start_pos=$2
end_pos=$3
numdiscrep=0 #Number of discrepancies between reference genome and reference nucleotides in SNP file in range of interest


numstrands=$(ls -1q data/quality_variant*.txt | wc -l) #Number of strands that we have
((seqlength = $end_pos-$start_pos+1)) #Length of sequence
printf -v startnum "%09d" $start_pos #padding with zeros
printf -v endnum "%09d" $end_pos #padding with zeros
echo "5 ${seqlength}" > alignments/"$chrom_full"_"$startnum"_"$endnum".phy #Create output file with first line


#Sequence of nucleotides in the reference genome
reference=$(tail -n +2 data/TAIR10_chr"$1".fas | tr -d '\n' | tail -c +$2 | head -c $seqlength)


#We now build each strand's sequence based on the reference sequence and the list of its SNP's.
i=0
for file in data/quality_variant*.txt
do
    echo $file
    echo $i
    if [ $i -ge 5 ]  
    then 
        echo "hey"
        break 
    fi
    ((i++))
    echo "yo"
    indseq=$reference 

    #Create a temporary file snp.txt with list of SNP's in range of interest
    #Each line of snp.txt is an SNP in range of interest 
    awk -v awk_chrom="$chrom_full" -v awk_startpos=$start_pos -v awk_endpos=$end_pos '$2 ~ awk_chrom && $3 <= awk_endpos &&  $3 >= awk_startpos { print $3 "\t" $4 "\t" $5}' $file > snp.txt
    
    #We iterate through the lines of snp.txt to make the necessary edits to indseq 
    while read line; do
        position=$(echo $line | awk '{print $1}')
        refbase=$(echo $line | awk '{print $2}')
        subbase=$(echo $line | awk '{print $3}')
        dif=`expr $position - $start_pos`
        
        #Check that reference genome and reference nucleotide in SNP file are the same. 
        #If they aren't, print error.
        #If they are, insert subbase into indseq.
        if [ $refbase != ${indseq:$dif:1} ]
        then 
            echo "Discrepancy between reference genome and reference nucleotides in SNP files at position $position"
            ((numdiscrep++))
        else 
            ((dif++))
            indseq=$(echo $indseq | sed "s/./$subbase/$dif")
        fi
    done < snp.txt

    #Add line to output file
    strand=$(head -1 $file | awk '{print $1}')
    echo "$strand  $indseq" >> alignments/"$chrom_full"_"$startnum"_"$endnum".phy
    echo "Allignment of strand $strand" generated
done

rm snp.txt #Delete temp file snp.txt

#Any discrepancies?
if [ $numdiscrep -eq 0 ] 
then 
    echo "No discrepancies between reference genome and reference nucleotides in any of the SNP files!"
fi
