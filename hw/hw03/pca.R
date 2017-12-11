library("png")
library("reshape")
library("ggplot2")

# training
filepath = "~/Developments/csci454-biometrics/hw/hw03/trainingfaces2/"
filenames = list.files(filepath, pattern = "*.png")
fullpathnames = paste(filepath, filenames, sep="")

training <- c()
for(i in 1:length(fullpathnames)) {
  training <- cbind(training, as.vector(readPNG(fullpathnames[1])))
}

# testing 
filepath.test = "~/Developments/csci454-biometrics/hw/hw03/testingfaces2/"
filenames.test = list.files(filepath.test, pattern = "*.png")
fullpathnames.test = paste(filepath.test, filenames.test, sep="")

testing <- c()
for(i in 1:length(fullpathnames.test)) {
  d <- cbind(as.vector(readPNG(fullpathnames.test[i])))
  testing <- cbind(testing, et %*% d)
}

pca(training,testing)

pca <- function(training, testing){
  the.mean <- rowMeans(training)
  xmean <- apply(training, 1, function(x) x-the.mean)
  
  xt.matrix <- t(xmean)
  covariance <- xmean %*% xt.matrix;
  
  ev = eigen(covariance)
  ten.eigen.vectors <- ev$vectors[,1:10]
  et <- t(ten.eigen.vectors)
  
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
