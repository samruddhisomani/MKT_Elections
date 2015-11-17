numdata1 = read.csv('GitHub/MKT_Elections/data/grouped_attitudes.csv')
numdata[is.na(numdata)] <- 0


d_cor <- as.matrix(cor(numdata1))
d_cor_melt <- arrange(melt(d_cor), -abs(value))
dplyr::filter(d_cor_melt, value > .5)

masterdata = read.csv('GitHub/MKT_Elections/data/MasterData.csv', header=TRUE)
cutmasterdata = masterdata[1:85,]

cutmasterdata$Rep_Percent[cutmasterdata$Year==2004]<- cutmasterdata$Rep_Percent[cutmasterdata$Year==2004]/100 
cutmasterdata$Dem_Percent[cutmasterdata$Year==2004]<- cutmasterdata$Dem_Percent[cutmasterdata$Year==2004]/100

library(pls)

model = plsr(Rep_Percent ~ VCF9133 + VCF9132 + VCF9131 + VCF9122 + VCF9096 + VCF9095 + VCF9094 + VCF9093 + VCF9092 + VCF9089 + VCF9088 + VCF9087 + VCF9086 + VCF9085 + VCF9084 + VCF9081 + VCF9049 + VCF9048 + VCF9047 + VCF9045 + VCF9042 + VCF9041 + VCF9040 + VCF9039 + VCF9037 + VCF9031 + VCF9030c + VCF9030b + VCF9030a + VCF9030 + VCF9023 + VCF9022 + VCF9021 + VCF9018 + VCF9017 + VCF9016 + VCF9015 + VCF9014 + VCF9013 + VCF9009 + VCF9005 + VCF0894 + VCF0890 + VCF0888 + VCF0887 + VCF0886 + VCF0881 + VCF0880a + VCF0880 + VCF0879a + VCF0879 + VCF0878 + VCF0877a + VCF0877 + VCF0876a + VCF0876 + VCF0872 + VCF0871 + VCF0870 + VCF0867a + VCF0867 + VCF0854 + VCF0853 + VCF0852 + VCF0851 + VCF0850 + VCF0849 + VCF0847 + VCF0846 + VCF0843 + VCF0839 + VCF0838 + VCF0830 + VCF0824 + VCF0823 + VCF0809 + VCF0806 + VCF0804 + VCF0803 + VCF0801 + VCF0724 + VCF0714 + VCF0713 + VCF0710 + VCF0709 + VCF0708 + VCF0707 + VCF0706 + VCF0705 + VCF0704a + VCF0704 + VCF0703 + VCF0702 + VCF0656 + VCF0649 + VCF0648 + VCF0624 + VCF0614 + VCF0613 + VCF0609 + VCF0606 + VCF0605 + VCF0604 + VCF0504 + VCF0503 + VCF0502a + VCF0502 + VCF0501 + VCF0493 + VCF0487 + VCF0481 + VCF0475 + VCF0451 + VCF0450 + VCF0392 + VCF0386 + VCF0380 + VCF0374 + VCF0373 + VCF0372 + VCF0371 + VCF0370 + VCF0361 + VCF0360 + VCF0359 + VCF0358 + VCF0349 + VCF0348 + VCF0347 + VCF0346 + VCF0310 + VCF0291 + VCF0290 + VCF0253 + VCF0234 + VCF0233 + VCF0232 + VCF0231 + VCF0228 + VCF0227 + VCF0224 + VCF0223 + VCF0220 + VCF0219 + VCF0218 + VCF0217 + VCF0213 + VCF0212 + VCF0211 + VCF0210 + VCF0209 + VCF0207 + VCF0206 + VCF0204, data = cutmasterdata, validation = "CV")

names = colnames(cutmasterdata)
wantednames = names[4:157]

str = ""

for (i in 1:154){
  str = paste(wantednames[i], str, sep=" + ")
}

#use output of str and copy paste into model step above, cutting out quotes and trailing +
#str

loaded_weights = model$loadings

scores = model$scores
first_scores = scores[,1:2]

states = rep("", 85)
for (i in 1:85){
  states[i] = paste(cutmasterdata[i,1], cutmasterdata[i,3], sep=", ")
}
first_scores_state = cbind(first_scores, states)

sqrt(mean(model$residuals^2))
