setwd("/root/文档/RProject/bytecup")

uinfo <- read.table("user_info.txt", stringsAsFactors = F)
colnames(uinfo) <- c("uid", "ulab", "wid", "cid")
rownames(uinfo) <- uinfo$uid
uinfo <- uinfo[,-1]

qinfo <- read.table("question_info.txt", stringsAsFactors = F)
colnames(qinfo) <- c("qid", "qlab", "wid", "cid", "likes", "ans", "gans")
rownames(qinfo) <- qinfo$qid
qinfo <- qinfo[,-1]

train <- read.table("invited_info_train.txt",  stringsAsFactors = F)
colnames(train) <- c("qid", "uid", "is.answered")
train$is.answered <- as.logical(train$is.answered)