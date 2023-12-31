source("src/Functions.R")

args <- commandArgs(trailingOnly = TRUE)
infile1 <- args[1]
infile2 <- args[2]
outfile1 <- args[3]
outfile2 <- args[4]
Bin_U <- 10^as.numeric(args[5])
num.iter <- as.numeric(args[6])

# Loading
X <- as.matrix(read.table(infile1, header=FALSE))
J <- as.numeric(read.table(infile2, header=FALSE))

# NMF without binary regularization
out <- dNMF(X=X, J=J, Bin_U=Bin_U, num.iter=num.iter)
pctBin <- zero_one_percentage(out$U)

# Save
write.table(pctBin, outfile1, row.names=FALSE, col.names=FALSE, quote=FALSE)
save(out, file=outfile2)
