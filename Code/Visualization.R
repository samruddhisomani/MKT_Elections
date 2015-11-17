library(gtools)
library(ggplot2)
library(rgdal)
library(rgeos)
library(maptools)
library(ggthemes)

#why transform

x=seq(0,1,by=.01)
y=4*x - 4*x**2
plot(x,y,main="Why Transform?",xlab="Probability",ylab="Transformed")

#reading data
dist <- readShapeSpatial("../data/cb_2014_us_state_500k.shp")

data<-read.csv("../data/MasterData2.csv")

#transforming data in ggplot object
fort<-fortify(dist,region='NAME')

#cleaning out stuff that's messing up the graph (We might need to add Alaska and Hawaii)
list=c('American Samoa', 'Puerto Rico', 'Commonwealth of the Northern Mariana Islands','United States Virgin Islands', 'Guam')

fortS<-fort[!(fort$id%in%list),]
fortS<-fortS[fort$long<100,]
fortS<-fortS[fort$lat>10,]

#pretty pictures
ggplot(data, aes(map_id = as.factor(State))) + 
  geom_map(map = fort,aes(fill=Rep_Percent),color='black') + 
  expand_limits(x=c(-180,-60),y=c(15,75)) +
  scale_fill_gradient2(low="blue", high="red",midpoint=.5,space='Lab',name="Republican Share")+
  theme_tufte()+
  facet_grid(Year~.)

ggplot(data, aes(map_id = as.factor(State))) + 
  geom_map(map = fort,aes(fill=rep_trans),color='black') + 
  expand_limits(x=c(-180,-60),y=c(15,75)) +
  scale_fill_gradient(high='white',name="Transform")+
  theme_tufte()+
  facet_grid(Year~.)



# Leons Graph Code
pred_inv = read.csv("../data/transformed_all_leon.csv")
pred_inv = pred_inv$rep_logit

data_graph = as.data.frame(cbind(data_sub[2],data_sub[4],pred_inv))

ggplot(data_graph, aes(map_id = as.factor(State))) + 
  geom_map(data=fort,map=fort,aes(map_id=as.factor(id)),fill='pink',color='black')+
  geom_map(map=fort,aes(fill=pred_inv),color='black') + 
  expand_limits(x=c(-180,-60),y=c(15,75)) +
  scale_fill_gradient(high='white',name="Transform")+
  theme_tufte()+
  facet_grid(Year~.)


