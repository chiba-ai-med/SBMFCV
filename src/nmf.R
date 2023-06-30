source("src/Functions.R")

args <- commandArgs(trailingOnly = TRUE)
infile <- args[1]
outfile <- args[2]
J <- as.numeric(args[3])
num.iter <- as.numeric(args[4])
ratio <- as.numeric(args[5])

# Loading
X <- as.matrix(read.table(infile, header=FALSE))

# Mask Matrix
M <- kFoldMaskTensor(X, k=round(100/ratio),
	seeds=rbinom(1, 1E+5, 0.5))[[1]]

# NMF without binary regularization
out <- rev(dNMF(X=X, M=M, J=J, num.iter=num.iter)$TestRecError)[1]

# Save
write.table(out, outfile, row.names=FALSE, col.names=FALSE, quote=FALSE)
