#! /Applications/Julia-0.4.5.app/Contents/Resources/julia/bin/julia
# Geoffrey Hannigan
# University of Michigan

# Setting dependencies
using Bio.Align
using Bio.Seq
using ArgParse

# Setup ArgParse
argx = ArgParseSettings()
@add_arg_table argx begin
    "--input", "-i"
        help = "Input fasta file for identifying circular contigs."
    "--output", "-o"
        help = "Output file to write reults."
    "--length", "-l"
        help = "Length of sequence window for detecting repeats."
        default = 100
    "--thresh", "-t"
        help = "Threshold (percent of length) for circular contig."
        default = 0.97
end

parsed_args = parse_args(ARGS, argx)

problem = LocalAlignment()

scoremodel = AffineGapScoreModel(
    match=5,
    mismatch=-4,
    gap_open=-4,
    gap_extend=-1
)

filepath = parsed_args["input"]
fileout = parsed_args["output"]
outputfile = open(fileout, "w")
hitlength = parsed_args["length"]
threshold = hitlength * 5 * parsed_args["thresh"]
maxscore = hitlength * 5
print("Perfect alignment score is $maxscore\n")
inputfasta = FASTA.Reader(open( filepath))


for s in inputfasta
    alignment_result = pairalign(problem, FASTA.sequence(s , 1:hitlength), FASTA.sequence(s , hitlength:length(FASTA.sequence(s))), scoremodel)
    scorestring = score(alignment_result)
    seqname = FASTA.identifier(s)
    if scorestring > threshold
        write(outputfile, "$seqname\t$scorestring\n")
    end
end

print("Complete\n")
