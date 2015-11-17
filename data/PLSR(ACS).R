data=read.csv('MasterData.csv')
data$Rep_Percent[data$Year==2004]<-data$Rep_Percent[data$Year==2004]/100 
data$Dem_Percent[data$Year==2004]<-data$Dem_Percent[data$Year==2004]/100

masterdata2=read.csv('MasterData2.csv')


data2=data[1:85,]
masterdata=masterdata2[1:85,]

library(pls)
model_anes=plsr(rep_logit~VCF9133+ VCF9132+ VCF9131+ VCF9122+ VCF9096+ VCF9095+ VCF9094+ VCF9093+ VCF9092+ VCF9089+ VCF9088+ VCF9087+ VCF9086+ VCF9085+ VCF9084+ VCF9081+ VCF9049+ VCF9048+ VCF9047+ VCF9045+ VCF9042+ VCF9041+ VCF9040+ VCF9039+ VCF9037+ VCF9031+ VCF9030c+ VCF9030b+ VCF9030a+ VCF9030+ VCF9023+ VCF9022+ VCF9021+ VCF9018+ VCF9017+ VCF9016+ VCF9015+ VCF9014+ VCF9013+ VCF9009+ VCF9005+ VCF0894+ VCF0890+ VCF0888+ VCF0887+ VCF0886+ VCF0881+ VCF0880a+ VCF0880+ VCF0879a+ VCF0879+ VCF0878+ VCF0877a+ VCF0877+ VCF0876a+ VCF0876+ VCF0872+ VCF0871+ VCF0870+ VCF0867a+ VCF0867+ VCF0854+ VCF0853+ VCF0852+ VCF0851+ VCF0850+ VCF0849+ VCF0847+ VCF0846+ VCF0843+ VCF0839+ VCF0838+ VCF0830+ VCF0824+ VCF0823+ VCF0809+ VCF0806+ VCF0804+ VCF0803+ VCF0801+ VCF0724+ VCF0714+ VCF0713+ VCF0710+ VCF0709+ VCF0708+ VCF0707+ VCF0706+ VCF0705+ VCF0704a+ VCF0704+ VCF0703+ VCF0702+ VCF0656+ VCF0649+ VCF0648+ VCF0624+ VCF0614+ VCF0613+ VCF0609+ VCF0606+ VCF0605+ VCF0604+ VCF0504+ VCF0503+ VCF0502a+ VCF0502+ VCF0501+ VCF0493+ VCF0487+ VCF0481+ VCF0475+ VCF0451+ VCF0450+ VCF0392+ VCF0386+ VCF0380+ VCF0374+ VCF0373+ VCF0372+ VCF0371+ VCF0370+ VCF0361+ VCF0360+ VCF0359+ VCF0358+ VCF0349+ VCF0348+ VCF0347+ VCF0346+ VCF0310+ VCF0291+ VCF0290+ VCF0253+ VCF0234+ VCF0233+ VCF0232+ VCF0231+ VCF0228+ VCF0227+ VCF0224+ VCF0223+ VCF0220+ VCF0219+ VCF0218+ VCF0217+ VCF0213+ VCF0212+ VCF0211+ VCF0210+ VCF0209+ VCF0207+ VCF0206+ VCF0204 ,data=masterdata, validation = "CV")


var=names(data2[4:157])
str=''
for (i in 1:154){
  str=paste(var[i],str,sep="+ ")
}

acs_var=names(data2[158:194])

stracs=''
for (i in 1:37){
  stracs=paste(acs_var[i],stracs,sep="+ ")
}

model_acs=plsr(rep_logit~EST_VC284+ EST_VC283+ EST_VC281+ EST_VC194+ EST_VC192+ EST_VC191+ EST_VC190+ EST_VC187+ EST_VC171+ EST_VC167+ EST_VC166+ EST_VC135+ EST_VC134+ EST_VC116+ EST_VC115+ EST_VC112+ EST_VC110+ EST_VC108+ EST_VC95+ EST_VC94+ EST_VC93+ EST_VC92+ EST_VC91+ EST_VC63+ EST_VC59+ EST_VC58+ EST_VC56+ EST_VC55+ EST_VC48+ EST_VC42+ EST_VC41+ EST_VC13+ EST_VC12+ EST_VC11+ EST_VC06+ EST_VC05+ EST_VC03+ EST_VC283+ EST_VC281+ EST_VC194+ EST_VC192+ EST_VC191+ EST_VC190+ EST_VC187+ EST_VC171+ EST_VC167+ EST_VC166+ EST_VC135+ EST_VC134+ EST_VC116+ EST_VC115+ EST_VC112+ EST_VC110+ EST_VC108+ EST_VC95+ EST_VC94+ EST_VC93+ EST_VC92+ EST_VC91+ EST_VC63+ EST_VC59+ EST_VC58+ EST_VC56+ EST_VC55+ EST_VC48+ EST_VC42+ EST_VC41+ EST_VC13+ EST_VC12+ EST_VC11+ EST_VC06+ EST_VC05+ EST_VC03,data=masterdata, validation='CV')

library(gtools)
acsRMSE=sqrt(mean(model_acs$residuals^2))
anesRMSE=sqrt(mean(model_anes$residuals^2))

acspred=predict(model_acs,comps=1:37)
acspred_trans=inv.logit(acspred)
bind=cbind(pred=acspred_trans,act=masterdata$rep_trans,diff=acspred_trans-masterdata$rep_trans)
sqrt(mean(bind[,3]^2))

bindstate=cbind(masterdata[2],masterdata[4], bind)

head(masterdata)

adspend=masterdata[,'PercentMoney']
cor(bindstate[,3],adspend,method='spearman')

library(gtools)
library(ggplot2)
library(rgdal)
library(rgeos)
library(maptools)
library(ggthemes)

dist <- readShapeSpatial("../data/cb_2014_us_state_500k.shp")
fort<-fortify(dist,region='NAME')
ggplot(bindstate, aes(map_id = as.factor(State))) + 
    geom_map(data=fort,aes(map_id=as.factor(id)),map=fort,fill='pink',color='black')+
    geom_map(map = fort,aes(fill=bindstate[,3]),color='black') + 
  expand_limits(x=c(-180,-60),y=c(15,75)) +
  scale_fill_gradient(high='white',name="Transform")+
  theme_tufte()+
  facet_grid(Year~.)


bindstate
