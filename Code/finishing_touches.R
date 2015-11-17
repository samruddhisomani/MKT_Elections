library(ggplot2)
library(ggthemes)

data<-read.csv('../data/MasterDataLags.csv',nrows=85)
leon<-read.csv('../data/transformed_all_leon.csv')
model<-read.csv('../data/model_output.csv')
lags<-read.csv('../data/lags.csv')

#columnizing
adspend<-data$PercentMoney
state<-model$State
year<-model$Year
all<-leon$rep_logit
acs<-model$acs_predict
anes<-model$anes_predict
lags<-lags$x
ev<-data$Rep_EV+data$Dem_EV

#data framing
merged<-cbind.data.frame(adspend,state,year,all,acs,anes)

#correlation between transform and adspend
cor(all,adspend,method='spearman')

#correlation with interaction
interaction<-ev*adspend

cor(interaction, adspend,method='spearman')

df<-cbind.data.frame(state,year,all,ev,adspend+.00001)
names(df)<-c('state','year', 'all','ev','ad')
df[which.min(df$all),]

ggplot(data=df)+
  geom_point(aes(x=all,y=ev,color=ad),size=4)+
  theme_tufte()+
  coord_cartesian(xlim=c(.75,1.01))+
  scale_color_gradient(limits=c(.05,.25),high='green',trans='log')
  



