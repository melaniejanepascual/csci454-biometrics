library("png")
library("reshape")
library("ggplot2")

img1 <- c()
img2 <- c()
img3 <- c()
img4 <- c()
img5 <- c()
img6 <- c()
img7 <- c()
img8 <- c()
img9 <- c()

img1t <- c()
img2t <- c()
img3t <- c()
img4t <- c()
img5t <- c()
img6t <- c()
img7t <- c()
img8t <- c()
img9t <- c()

# aligned images - training
filepath.aligned ="~/Developments/csci454-biometrics/hw/hw03/trainingrotated2/"
filenames.aligned = list.files(filepath, pattern = "*.png")
fullpathnames.aligned = paste(filepath, filenames, sep="")

aligned.images <- c()
for(i in 1:length(fullpathnames.aligned)) {
  aligned.images <- cbind(aligned.images, as.vector(readPNG(fullpathnames.aligned[i])))
}

normalized.aligned.images <- c()
for(i in 1:length(fullpathnames.aligned)) {
  x <- readPNG(fullpathnames.aligned[i])
  minimum <- min(x)
  maximum <-max(x)
  normalized.aligned.images <-c((x - minimum)/
                                  (maximum-minimum))
  aligned.images <- cbind(aligned.images, normalized.aligned.images)
  img1 <- x[c(1:20), c(1:20)]
  img2 <- x[c(1:20), c(21:40)]
  img3 <- x[c(1:20), c(41:60)]
  img4 <- x[c(21:40), c(1:21)]
  img5 <- x[c(21:40), c(21:40)]
  img6 <- x[c(21:40), c(41:60)]
  img7 <- x[c(41:60), c(1:20)]
  img8 <- x[c(41:60), c(21:40)]
  img9 <- x[c(41:60), c(41:60)]
}

# normalized images - testing
filepath.aligned.test = "~/Developments/csci454-biometrics/hw/hw03/testingaligned2/"
filenames.aligned.test = list.files(filepath, pattern = "*.png")
fullpathnames.aligned.test = paste(filepath, filenames, sep="")

images <- c()
normalized.images <- c()
for(i in 1:length(fullpathnames.aligned.test)) {
  x <- readPNG(fullpathnames.aligned.test[i])
  minimum <- min(x)
  maximum <-max(x)
  normalized.images <-(x - minimum)/
    (maximum-minimum)
  images <- cbind(images, normalized.images)
  img1t <- x[c(1:20), c(1:20)]
  img2t <- x[c(1:20), c(21:40)]
  img3t <- x[c(1:20), c(41:60)]
  img4t <- x[c(21:40), c(1:21)]
  img5t <- x[c(21:40), c(21:40)]
  img6t <- x[c(21:40), c(41:60)]
  img7t <- x[c(41:60), c(1:20)]
  img8t <- x[c(41:60), c(21:40)]
  img9t <- x[c(41:60), c(41:60)]
}

pca <- function(training, testing){
  the.mean <- rowMeans(training)
  xmean <- apply(training, 1, function(x) x-the.mean)
  xt.matrix <- t(xmean)
  covariance <- xmean %*% xt.matrix;
  ev = eigen(covariance)
  twenty.eigen.vectors <- ev$vectors[,1:20]
  et <- t(twenty.eigen.vectors)
  weight <- et %*% xmean
  difference <- matrix(data = NA, nrow = dim(testing)[2], ncol = dim(testing)[2])
  for(i in 1:229) {
    for(j in 1:229) {
      difference[i,j] <- sum(abs(testing[,i] - testing[,j]))
    }
  }
  rownames(difference) <- filenames.test
  colnames(difference) <- filenames.test
  distance.scores.table <- melt(difference)[melt(upper.tri(difference))$value,]
  return(distance.scores.table)
}


## final score
score <- pca(img1, img1t) + 2*pca(img2, img2t) + pca(img3, img3t) + 2*pca(img4, img4t)   + 2*pca(img5, img5t) + 2*pca(img6, img6t) + pca(img7, img7t) + 2*pca(img8, img8t) + 
  pca(img9, img9t)
