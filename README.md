# ccontigs
Detect contigs of complete circular genomes

## How to download
Simply download the set of files by clicking the `releases` button above and downloading the compressed file. You are also of course free to clone or fork the repository.

## How to test the scripts
It is always important to test scripts before you run them. To this end, I encourage you to test the processes after downloading them. Do do this, simply open the terminal and move into the ccontigs directory. Then run the following:

```bash
bash testcode.sh
```

This will download and format a test dataset in the `test` directory using a set of pre-defined virus reference genomes, their accession numbers, and whether they have circular/linear genomes. Sequencing overlap was simulated by repeating the beginning of the genome at the end of the sequence. This overlap is used to detect a completed circular genome.

The output in your terminal should look something like this. If you fail any of the steps, you will need to fix the problem until they pass.

```
Running test
Downloading Sequences
--2016-09-11 18:57:45--  http://www.ebi.ac.uk/ena/data/view/KF482069,M14428,EF568108,X58839,CU468217,KC821618,KP063541,AB981169,JQ809663,KJ019160,K02718,FJ882854,KJ938717,KP133078,Z24758,GU071086,JQ234922,KF430219,GQ368252,JX051319,KP280063,GU071094,AY954962,EF177456,DQ163914,GU071103,AY500152,KF017927,KM279937,JN699002,FJ848881,KC690136,AJ556162,JF767208,AY526908,KF669652,JX080304,KM067278,KR902979&display=fasta
Resolving www.ebi.ac.uk... 193.62.193.80
Connecting to www.ebi.ac.uk|193.62.193.80|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: unspecified [text/plain]
Saving to: './tmpout'

./tmpout                                         [                            <=>                                                              ]   2.59M   436KB/s    in 6.1s    

2016-09-11 18:57:51 (434 KB/s) - './tmpout' saved [2717238]

Completed
Complete!
>>> PASS: Downloaded and formatted referece fasta
Perfect alignment score is 500
Complete
>>> PASS: ccontigs ran properly on reference file
```

## How to run ccontigs
Once you have passed the tests, you are ready to run `ccontigs`. Simply run the script like this:

```bash
julia ccontigs.jl -i ./test/testout.fa -o ./test/juliaout.tsv
```

You may read more in the help menu by running the script as:

```bash
julia ccontigs.jl -h
```

Output will be as follows.

```

usage: ccontigs.jl [-i INPUT] [-o OUTPUT] [-l LENGTH] [-t THRESH] [-h]

optional arguments:
  -i, --input INPUT    Input fasta file for identifying circular
                       contigs.
  -o, --output OUTPUT  Output file to write reults.
  -l, --length LENGTH  Length of sequence window for detecting
                       repeats. (default: 100)
  -t, --thresh THRESH  Threshold (percent of length) for circular
                       contig. (default: 0.97)
  -h, --help           show this help message and exit

```
