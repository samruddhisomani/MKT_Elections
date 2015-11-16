library(entropy)
library(gtools)

data = read.csv("../data/MasterData.csv")

data$Rep_Percent[data$Year==2004]<-data$Rep_Percent[data$Year==2004]/100
data$Dem_Percent[data$Year==2004]<-data$Dem_Percent[data$Year==2004]/100


data$rep_trans = 4*data$Rep_Percent - 4*(data$Rep_Percent)**2
data$dem_trans = 4*data$Dem_Percent - 4*(data$Dem_Percent)**2
data$rep_logit = logit(data$rep_trans,min=min(data$rep_trans)-0.0001,max=max(data$rep_trans)+0.0001)
data$dem_logit = logit(data$dem_trans,min=min(data$dem_trans)-0.0001,max=max(data$dem_trans)+0.0001)

write.csv(data,"../data/MasterData2.csv")

