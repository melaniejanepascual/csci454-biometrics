library("png")

img = readPNG("~/source/image.png")
#This assignment requires you to transform a matrix into a single-dimension 
#vector. This can be done using the as.vector function.

vec_img = as.vector(img)
# Another tool that will be useful in this assignment is the transpose function. 

aMatrix = t(aMatrix)
# Lastly, you will need to use the Eigenvector solver to find the Eigenvectors 
# and Eigenvalues from the covariance matrix. This can be done using the 'eigen' 
# function.

ev = eigen(aMatrix)

# To access the Eigenvectors and Eigenvalues, use the '$' operator

ev$vectors
ev$values

## More help

install.packages("reshape")
library(reshape)

melt()

a = matrix(c(1:64), nrow = 8, ncol = 8)

## get scores in upper triangular matrix ???

upper.tri(a)

## give boolean values - for what?

a[upper.tri(a)] 

## shows set of scores in upper triangular section

melt(a)


melt(a[upper.tri(a)])

## end function to get NxN matrix to become a set of rows with a set of values in th end
## can become the sequence ID
melt(a)[melt(upper.tri(a))$value,]

melt(upper.tri(a))$value

## melt function is doing matrix to list