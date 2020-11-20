See:
- [overview](overview.md) of the project: learning goals,
  group work, and overview of tasks and pipeline
- [step by step](stepsinstructions.md) instructions.

Now delete these lines and replace by your own "readme"
to document your pipeline.
Your result summary should go in a different markdown file,
`report.md`.

## Task 1
TAIR10 Reference genome file sizes are as follows.
1. _chr1.fas: 29.4 MB
2. _chr2.fas: 19.0 MB
3. _chr3.fas: 22.7 MB
4. _chr4.fas: 17.9 MB
5. _chr5.fas: 26.1 MB
6. _chrC.fas: 153 kB
7. _chrM.fas: 363 kB

## Task 2
The script downloadSNP.sh should work for downloading. We still need to (see TODOs in file)
1. Do analysis of the log.out to add to the report.
2. Confirm all files are downloading correctly, especially with bash.
3. There may be a way to use one curl command instead of a for loop, which would probably be more efficient

I included a commented out line that only downloads a small subset (15 of the 216) of the files for testing. The comments indicate what lines need to be (un)commented to use this.

Updated script of downloadSNP.sh:
1. analysis has done on the output files (range of size and total number)
2. a summary.txt file will be outputed, which is the summary of the number of files been downloaded; the range of the size of downloaded files
3. I would suggest to keep the current code, instead of using awk to complete everything with one curl command, which might be easier to debug in the future if we need to go back to this script to make revisement. 
