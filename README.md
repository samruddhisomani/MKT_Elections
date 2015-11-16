# Marketing Project

[Proposal] (https://docs.google.com/presentation/d/1XKd1t11IwjHkc47qtmcEW2uJ0lqwZ-IBXNpEu7IWl4c/edit?usp=sharing)

### TO DO LIST
- PLSR on attitudinal data
  - Corr plot to motivate
- Transform y (voteshares) with logit
- Aggregate attitudes

Code to fix percentages:

data$Rep_Percent[data$Year==2004]<-data$Rep_Percent[data$Year==2004]/100
data$Dem_Percent[data$Year==2004]<-data$Dem_Percent[data$Year==2004]/100

Sam's quadratic bound stuff:
transform=4*data$Rep_Percent - 4*(data$Rep_Percent)**2
