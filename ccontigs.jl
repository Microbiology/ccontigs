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

for s in open( filepath, FASTA )
    alignment_result = pairalign(problem, s.seq[1:50], s.seq[51:end], scoremodel)
    scorestring = score(alignment_result)
    seqname = s.name
    write(outputfile, "$scorestring\t$seqname\n")
end
