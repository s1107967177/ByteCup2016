setwd("/root/文档/RProject/bytecup")
source("read_data.R")
source("attribute_construction.R")
cat("train adding ...")
train <- attr.add(train)
save(train, file = "train.RData")
vnolab <- read.csv("validate_nolabel.txt", stringsAsFactors = F, header = T)
cat("vnolab adding...")
vnolab <- attr.add(vnolab)
save(vnolab, file = "vnolab.RData")

library(kernlab)
train$is.answered <- as.factor(train$is.answered)
fit <- ksvm(is.answered~freq+exp, data = train, kernel = "vanilladot", prob.model = T)
vnolab$label <- predict(fit, vnolab, type = "probabilities")[,2]

write.csv(vnolab[,1:3], file = "temp.csv", fileEncoding = "utf8", row.names = F)