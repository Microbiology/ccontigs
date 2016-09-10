#! /usr/bin/python
# Geoffrey Hannigan
# University of Michigan

from Bio import pairwise2
from Bio.pairwise2 import format_alignment
from Bio import SeqIO
import argparse
import pickle

parser = argparse.ArgumentParser(description='Identifying circular contigs.')

parser.add_argument('-i', '--input')
parser.add_argument('-o', '--output')

args = parser.parse_args()

fasta_sequences = SeqIO.parse(open(args.input),'fasta')

# Define empty dictionary
d = {}

for fasta in fasta_sequences:
	name, sequence = fasta.id, fasta.seq.tostring()
	d[name] = 0
	for a in pairwise2.align.localms(sequence[:50], sequence[51:], 2, -2, -.5, -.1):
		print name
		d[name] = a[2] if a[2] > d.get(name) else d.get(name)

with open(args.output, 'w') as f:
    for key, value in d.items():
        f.write('%s\t%s\n' % (key, value))
