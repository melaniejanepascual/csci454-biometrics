library("png")

img = readPNG("~/source/image.png")
#This assignment requires you to transform a matrix into a single-dimension 
# vector. This can be done using the as.vector function.

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