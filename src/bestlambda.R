source("src/Functions.R")

args <- commandArgs(trailingOnly = TRUE)
infile <- args[1]
outfile <- args[2]
bin <- as.logical(args[3])

if(bin){
	# Loading
	out <- read.table(infile, header=FALSE)
	colnames(out) <- c("trial", "lambda", "value")

	# Best lambda
	group_by(out, lambda) |> summarize(Avg = mean(value)) -> avg
	min_position <- which(avg[, 2] >= 90)[1]
	if(is.na(min_position)){
		msg1 <- "The factor matrix is not yet sufficiently binarized."
		msg2 <- "Set a larger --lambda_max value!!!"
		msg <- paste(msg1, msg2)
		stop(msg)
	}
	best_lambda <- avg[min_position, 1]

	# Save
	write.table(as.numeric(best_lambda), outfile, row.names=FALSE, col.names=FALSE, quote=FALSE)
}else{
	write.table(1E-10, outfile, row.names=FALSE, col.names=FALSE, quote=FALSE)
}