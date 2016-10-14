attr.con <- function(qid, uid) {
  qlab <- qinfo[qid,]$qlab
  train.sub <- train[train$uid == uid & qinfo[train$qid,]$qlab == qlab,]
  exp <- nrow(train.sub)                                  
  freq <- ifelse(exp, sum(train.sub$is.answered)/exp, 0)
  return(c(exp ,freq))
}

attr.add <- function(data) {
  library(doParallel)
  library(foreach)
  cl <- makeForkCluster(detectCores()-1)
  registerDoParallel(cl)
  newattr <- foreach (i = 1:nrow(data), .combine = rbind) %dopar% attr.con(data[i,1], data[i,2])
  stopCluster(cl)
  newattr <- as.data.frame(newattr)
  colnames(newattr) <- c("exp", "freq")
  data <- data.frame(data, newattr)
  return(data)
}