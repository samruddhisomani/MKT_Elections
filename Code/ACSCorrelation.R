library(corrplot)
library(ggplot2)
library(reshape2)
data=read.csv('acs.csv')
numdata=data
numdata$X=NULL
numdata$GEO.id=NULL
numdata$GEO.id2=NULL
numdata$GEO.display.label=NULL

corrplot(abs(cor(numdata)),method='color',cl.pos = 'n')

qplot(x=Var1, y=Var2, data=melt(abs(cor(numdata))), fill=value, geom="tile")+theme(axis.text.x = element_text(angle = 90, hjust = 1))
