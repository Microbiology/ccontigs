#! /bin/bash
# Geoffrey Hannigan
# University of Michigan

echo Running test

cd ./test || exit
bash ./downloadtestseqs.sh ./testvirusnumbers.tsv ./testout.fa
cd ../ || exit

diffcount=$(diff ./test/validation.fa ./test/testout.fa | wc -l)

if [[ ${diffcount} -gt 1 ]]; then
	echo FAIL: Did not properly download and format reference fasta
else
	echo ">>> PASS: Downloaded and formatted referece fasta"
fi

julia ccontigs.jl -i ./test/testout.fa -o ./test/juliaout.tsv

diffjulia=$(diff ./test/juliavalidation.tsv ./test/juliaout.tsv | wc -l)

if [[ ${diffjulia} -gt 1 ]]; then
	echo FAIL: ccontigs failed to run on reference file
else
	echo ">>> PASS: ccontigs ran properly on reference file"
fi

rm ./test/testout.fa
rm ./test/juliaout.tsv
