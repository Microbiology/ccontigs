#! /Applications/Julia-0.4.5.app/Contents/Resources/julia/bin/julia
# Geoffrey Hannigan
# University of Michigan

# Install dependencies
Pkg.add("Bio")
using Bio.Align
using Bio.Seq

problem = LocalAlignment()

scoremodel = AffineGapScoreModel(
    match=5,
    mismatch=-4,
    gap_open=-4,
    gap_extend=-1
)

alignment_result = pairalign(problem, dna"CGGATTA", dna"GGTTTAC", scoremodel)

score(alignment_result)
