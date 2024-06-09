source("src/Functions.R")

args <- commandArgs(trailingOnly = TRUE)
infile <- args[1]
outfile <- args[2]
output_sparse <- as.logical(args[3])

# Loading
U <- as.matrix(read.table(infile, header=FALSE))

if(output_sparse){
	U[which(U < 0.5)] <- 0
	U[which(U >= 0.5)] <- 1
	U <- as(U, "TsparseMatrix")
	# Save
	writeMM(U, outfile)
}else{
	# {0,1} => {-1,1}
	U[which(U < 0.5)] <- -1
	U[which(U >= 0.5)] <- 1
	# Save
	write.table(U, outfile, row.names=FALSE, col.names=FALSE, quote=FALSE, sep="\t")
}
