source("src/Functions.R")

args <- commandArgs(trailingOnly = TRUE)
infile1 <- args[1]
infile2 <- args[2]
outfile <- args[3]
Bin_U <- 10^as.numeric(args[4])
num.iter <- as.numeric(args[5])

# Loading
X <- as.matrix(read.table(infile1, header=FALSE))
J <- as.numeric(read.table(infile2, header=FALSE))

# NMF without binary regularization
dNMF(X=X, J=J, Bin_U=Bin_U, num.iter=num.iter)$U |> zero_one_percentage() -> out

# Save
write.table(out, outfile, row.names=FALSE, col.names=FALSE, quote=FALSE)
