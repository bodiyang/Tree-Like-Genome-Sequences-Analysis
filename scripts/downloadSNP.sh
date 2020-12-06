#!/bin/zsh
 
# this script downloads all quality_variant files from the 1001 genome project. The files selected are those
# listed at http://signal.salk.edu/atg1001/download.php. Files are downloaded from 
# http://signal.salk.edu/atg1001/data/Salk/quality_variant_[FILENAME].txt and stored in the 
# data/ directory named [FILENAME].txt, with the filename taken from the salk website.
# file summary.txt will be created which record the total number of file and the size of the files downloaded 

# this script should be run from the fp-group-2 folder, not the scripts folder

# if our data directory isn't created, make it
if [ ! -d 'data/' ]
then
    mkdir data
else # otherwise delete whatever's in it
    rm data/quality_variant*
fi

cd data

# download the list of files from the salk website, extract the filenames
curl -s http://signal.salk.edu/atg1001/download.php > filenames.txt

# to preview this script with fewer files, comment out this line
# TODO: is there a way we can do this with bash that doesn't require a filenames file?
# RES: A filename list would probably be necessary to be created to keep track, otherwise we need to use extremely complex pipelines to do the following steps of printing etc.
sed -nE -i '.bak' 's/.*accession\.php\?id=[A-Za-z0-9_]+>([A-Za-z0-9_]+)<.*/\1/pg' filenames.txt

# and uncomment these lines
# sed -nE -i '.bak' 's/.*accession\.php\?id=[A-Za-z0-9]+>([A-Za-z0-9_]+)<.*/\1/pg' filenames.txt
# our test doesn't download Aa_0, which is necessary for the summary
# curl "http://signal.salk.edu/atg1001/data/Salk/quality_variant_Aa_0.txt" -O 2>> "log.txt"


# variables required for printing progress
numfls=`wc -l filenames.txt | sed -nE 's/[[:space:]]*([0-9]+).*$/\1/pg'`
count=1
tothash=20

# loop over the filenames
# TODO: rewrite this with awk?
# RES: I would also suggest not using awk, easily to debug 

cat filenames.txt | while read flnm
do  

    # print our progress to stdout
    # check what shell we're using, nice progress printing only works with zsh
    shl=`ps -p $$ | grep -E 'zsh'`
    if [ ! -z $shl ]
    then
        numhash=$(( $count * $tothash / $numfls ))
        space=`printf ' %.0s' {1..$(( $tothash - $numhash ))}`
        hash=`printf '#%.0s' {0..$numhash}`
        printf "downloading file "$count" of "$numfls"  |"$hash$space"|"'\r'
    else
        echo "downloading file "$count" of "$numfls
    fi
    count=$(( $count + 1 ))

    # print the file name to the logfile so we know what file each line is referring to
    echo $flnm >> "log.txt"
    # download the actual files from the salk website
    # TODO: rewrite to use one curl request for all the files?
    curl "http://signal.salk.edu/atg1001/data/Salk/quality_variant_"$flnm".txt" -O 2>> "log.txt"

    message="\n"$flnm" not downloaded. See log.txt for details."
    filecontent=$(head -n 1 "quality_variant_"$flnm".txt" | grep -E "xml.*encoding.*>")
    # make sure this file was downloaded correctly
    if [ ! -f "quality_variant_"$flnm".txt" ] || [ `wc -l "quality_variant_"$flnm".txt" | sed -E 's/ //g'` = 0 ]
    then
        echo -e $message
    elif [[ ! -z $filecontent ]]
    then
        echo -e $message
        rm "quality_variant_"$flnm".txt"
    fi 
done

# summary for downloads

# the following code will go over the quality_variant_*.txt files to find the min and max size and print to summary.txt
min=$(wc -c quality_variant_Aa_0.txt | sed -nE 's/[[:space:]]*([0-9]+).*$/\1/pg')
max=0
count=0

for filename in quality_variant_*.txt
do
    size=$(wc -c $filename | sed -nE 's/[[:space:]]*([0-9]+).*$/\1/pg')
    #echo $size >> summary.txt
    count=$(( $count + 1 ))

    if [[ $min -gt $size ]]
    then
            min=$size
    fi

    if [[ $size -gt $max ]]
    then
            max=$size
    fi
done

echo $count" files downloaded" >> summary.txt

echo "the range of size of the files downloaded is from $min to $max" >> summary.txt
