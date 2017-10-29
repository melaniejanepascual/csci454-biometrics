install.packages("png")
library("png")
img <- readIMG("~/Developments/csci454-biometrics/IMG_0996.img")
dim(img) # size of image

img2 = as.vector(img)
length(img2)

img2 -> img3
x = cbind(img2, img3)

dim(x)

eigen()

t() # transpose function

