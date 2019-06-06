#! /bin/bash
# Geoffrey Hannigan
# University of Michigan

AccessionList=$1
OutputFile=$2

# Get string of accesstion numbers from my test list
AccString=$(cut -f 2 ${AccessionList} | tr '\n' ',' | sed 's/,$//')

# Download the test dataset
echo Downloading Sequences
wget "https://www.ebi.ac.uk/ena/data/view/${AccString}&display=fasta" -O ./tmpout

perl ./remove_block_fasta_format.pl \
	./tmpout \
	./tmpoutblocked
rm ./tmpout

perl -pe 's/^>ENA\|(.+)\|.*/>$1/'\
	./tmpoutblocked \
	> ./tmpoutsub
rm ./tmpoutblocked

# Repeat random length of beginning sequence at end of genome
while read line; do
	genometype=$(echo $line | awk '{ print $3 }')
	if [[ ${genometype} == "circular" ]]; then
		acc=$(echo $line | awk '{ print $2 }')
		grep -A 1 ${acc} ./tmpoutsub \
			| grep -v '\-\-' \
			| perl -pe 'my $randomvar = 750; s/^(\w{$randomvar})(\w+)/$1$2$1/ if $.==2' \
			| sed "s/\(>.*\)/\1_$genometype/"
	else
		acc=$(echo $line | awk '{ print $2 }')
		grep -A 1 ${acc} ./tmpoutsub \
			| grep -v '\-\-' \
			| sed "s/\(>.*\)/\1_$genometype/"
	fi
done < ${AccessionList} > ${OutputFile}

rm ./tmpoutsub

echo Complete!
