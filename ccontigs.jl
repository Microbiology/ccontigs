#! /Applications/Julia-0.4.5.app/Contents/Resources/julia/bin/julia
# Geoffrey Hannigan
# University of Michigan

# Setting dependencies
using Bio.Align
using Bio.Seq

problem = LocalAlignment()

scoremodel = AffineGapScoreModel(
    match=5,
    mismatch=-4,
    gap_open=-4,
    gap_extend=-1
)

filepath = ARGS[1]

for s in open( filepath, FASTA )
    alignment_result = pairalign(problem, s.seq[1:50], s.seq[51:end], scoremodel)
    print(score(alignment_result),"\t",s.name,"\n")
end
