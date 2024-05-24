args <- commandArgs(trailingOnly = TRUE)
infile1 <- args[1]
infile2 <- args[2]
outfile <- args[3]

if(infile1 != "_"){
	# Loading
	X_new <- as.matrix(read.table(infile1, header=FALSE))
	initV <- as.matrix(read.table(infile2, header=FALSE))

	checkSameSize <- ncol(X_new) != nrow(initV)
	if(checkSameSize){
		stop("Column size of X_new and row size of V must be the same!!!")
	}else{
		file.create(outfile)
	}
}else{
	file.create(outfile)
}