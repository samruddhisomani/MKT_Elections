library(gtools)
library(ggplot2)
library(rgdal)
library(rgeos)
library(maptools)
library(ggthemes)

#states_map <- map_data("state")

#reading data
dist <- readShapeSpatial("../data/cb_2014_us_state_500k.shp")

data<-read.csv("../data/MasterData.csv")
data$Rep_Percent[data$Year==2004]<-data$Rep_Percent[data$Year==2004]/100
data$Dem_Percent[data$Year==2004]<-data$Dem_Percent[data$Year==2004]/100

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

entropy=-2*data$Rep_Percent*log(data$Rep_Percent,base=2)

plot(data$Rep_Percent,transform)

max(entropy)

transform=4*data$Rep_Percent - 4*(data$Rep_Percent)**2

max(transform)

x=seq(0,1,by=.01)
y=4*x - 4*x**2
plot(x,y,main="Why Transform?",xlab="Probability",ylab="Transformed")




