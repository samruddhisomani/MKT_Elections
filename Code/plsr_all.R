library(pls)

data = read.csv("../data/MasterData2.csv")
data$lagdempct[data$Year==2008]<-data$lagdempct[data$Year==2008]/100

data_sub = data[1:85,-c(199:204,212,213,214)]

plsr_model = plsr(rep_logit~.,data=data_sub,validation="CV")

rmse = mean(plsr_model$residuals^2)
undo_logit = inv.logit(rmse)
share_error = (1-sqrt(1-undo_logit))/2


pred = predict(plsr_model,comps=1:75)
pred_inv = inv.logit(pred)
pred_rmse = sqrt(mean((pred_inv-data$rep_trans[1:85])^2))

adspend = data_sub[,"PercentMoney"]

cor(pred_inv,adspend,method="spearman")

write.csv(pred_inv,"../data/transformed_all_leon.csv")
