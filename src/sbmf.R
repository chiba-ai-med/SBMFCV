source("src/Functions.R")

args <- commandArgs(trailingOnly = TRUE)
infile1 <- args[1]
infile2 <- args[2]
outfile1 <- args[3]
outfile2 <- args[4]
Bin_U <- 10^as.numeric(args[5])
num.iter <- as.numeric(args[6])
bin <- as.logical(args[7])
beta <- as.numeric(args[8])
input_sparse <- as.logical(args[9])

if(bin){
	# Loading
	if(input_sparse){
		X <- 1.0 * as.matrix(readMM(infile1))
	}else{
		X <- as.matrix(read.table(infile1, header=FALSE))
	}
	J <- as.numeric(read.table(infile2, header=FALSE))

	# NMF with binary regularization
	out <- dNMF(X=X, J=J, Bin_U=Bin_U, num.iter=num.iter, Beta=beta)
	pctBin <- zero_one_percentage(out$U)

	# Save
	write.table(pctBin, outfile1, row.names=FALSE, col.names=FALSE, quote=FALSE)
	save(out, file=outfile2)
}else{
	file.create(outfile1)
	file.create(outfile2)
}