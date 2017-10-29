scores.matrix <- read.csv("hw1_matrix.csv")
scores.list <- read.csv("hw1_list.csv")

barplot(scores, main="Scores", xlab="distance scores", ylab="frequency")