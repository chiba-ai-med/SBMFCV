library("dcTensor")
library("nnTensor")
library("tidyverse")
library("Matrix")

# {0,1} percentage
zero_one_percentage <- function(U){
	no_zero_candidate <- length(intersect(which(U > -0.2), which(U < 0.2)))
	no_one_candidate <- length(intersect(which(U > 0.8), which(U < 1.2)))
	100 * (no_zero_candidate + no_one_candidate) / length(U)
}
