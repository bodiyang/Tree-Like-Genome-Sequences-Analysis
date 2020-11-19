#!/bin/zsh
 
# this script downloads all quality_variant files from the 1001 genome project. The files selected are those
# listed at http://signal.salk.edu/atg1001/download.php. Files are downloaded from 
# http://signal.salk.edu/atg1001/data/Salk/quality_variant_[FILENAME].txt and stored in the 
# data/ directory named [FILENAME].txt, with the filename taken from the salk website.

# this script should be run from the fp-group-2 folder, not the scripts folder

# if our data directory isn't created, make it
if [ ! -d 'data/' ]
then
    mkdir data
fi

# if we have a log file remove it, we'll need it fresh
if [ -f 'data/log.txt' ]
then 
    rm data/log.txt
fi
cd data

# download the list of files from the salk website, extract the filenames
curl -s http://signal.salk.edu/atg1001/download.php > filenames.txt

# to preview this script with fewer files, comment out this line
# TODO: is there a way we can do this with bash that doesn't require a filenames file?
sed -nE -i '.bak' 's/.*accession\.php\?id=[A-Za-z0-9_]+>([A-Za-z0-9_]+)<.*/\1/pg' filenames.txt

# and uncomment this line
# sed -nE -i '.bak' 's/.*accession\.php\?id=[A-Za-z0-9]+>([A-Za-z0-9_]+)<.*/\1/pg' filenames.txt


# variables required for printing progress
numfls=`wc -l filenames.txt | sed -nE 's/[[:space:]]*([0-9]+).*$/\1/pg'`
count=1
tothash=20

# loop over the filenames
# TODO: rewrite this with awk?
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

    # make sure this file was downloaded correctly
    if [ ! -f "quality_variant_"$flnm".txt" ] || [ `wc -l "quality_variant_"$flnm".txt" | sed -E 's/ //g'` = 0 ] \
        || [ `head -n 1 "quality_variant_"$flnm".txt" | grep -q -E "xml.*encoding.*>"` ]
    then
        echo "\n"$flnm" not downloaded. See log.txt for details."
    fi 
done

# TODO: summary for downloads