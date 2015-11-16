library(gtools)
library(ggplot2)
library(rgdal)
library(rgeos)
library(maptools)

#states_map <- map_data("state")

#reading data
dist <- readShapeSpatial("../data/cb_2014_us_state_500k.shp")

data<-read.csv("../data/Votes_all_years.csv")

#transforming data in ggplot object
fort<-fortify(dist,region='NAME')

#cleaning out stuff that's messing up the graph (We might need to add Alaska and Hawaii)
list=c('American Samoa', 'Puerto Rico', 'Commonwealth of the Northern Mariana Islands','United States Virgin Islands', 'Guam')

fortS<-fort[!(fort$id%in%list),]
fortS<-fortS[fort$long<100,]
#fortS<-fortS[fort$lat>10,]

#pretty pictures
ggplot(data, aes(map_id = as.factor(STATE))) + geom_map(map = fort) + expand_limits(x=c(-180,-60),y=c(15,75))




