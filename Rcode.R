##First all the data(from different cities) from JSON format was imported 
##in R and coverted to a big merged data frame called mainframe

for (i in 1:799
) {
  if(i==303){next}
  if(i==600){next}
  data=fromJSON(paste("dat_",toString(i),".json",sep=""),flatten=TRUE)
  dfnew=data.frame(data)
  mainframe=rbind.fill(mainframe,dfnew)
}
##After loads of data cleaning(i.e. removing useless variables) 
Databag = mainframe
library(tm)
library(SnowballC)
library(randomForest)
library(caTools)
#Omit NA values
Databag=na.omit(Datadude)
#Split data into training and testing sets
split=sample.split(Databag$AdsByCategoryResponse.AdsByCategoryData.docs.ad_view_count,SplitRation=0.7)
trainbag=subset(Databag,split==TRUE)
testbag=subset(Databag,split==FALSE)
corpus1=Corpus(VectorSource(Databag$AdsByCategoryResponse.AdsByCategoryData.docs.attribute_Also_includes))
corpus2=Corpus(VectorSource(Databag$AdsByCategoryResponse.AdsByCategoryData.docs.title))
corpus3=Corpus(VectorSource(Databag$AdsByCategoryResponse.AdsByCategoryData.docs.content))
corpus1=tm_map(corpus1,tolower)
corpus2=tm_map(corpus1,tolower)
corpus3=tm_map(corpus1,tolower)
corpus1=tm_map(corpus1,PlainTextDocument)
corpus2=tm_map(corpus1,PlainTextDocument)
corpus3=tm_map(corpus1,PlainTextDocument)
corpus1=tm_map(corpus1,removepunctuation)
corpus2=tm_map(corpus1,removepunctuation)
corpus3=tm_map(corpus1,removepunctuation)
corpus1=tm_map(corpus1,stemDocument)
corpus2=tm_map(corpus1,stemDocument)
corpus3=tm_map(corpus1,stemDocument)
f1=DocumentTermMatrix(corpus1)
f2=DocumentTermMatrix(corpus1)
f3=DocumentTermMatrix(corpus1)
s1=removeSparseTerms(f1,0.9)
s2=removeSparseTerms(f1,0.9)
s3=removeSparseTerms(f1,0.9)
t1=as.data.frame(as.matrix(s1))
t2=as.data.frame(as.matrix(s1))
t3=as.data.frame(as.matrix(s1))
t=cbind(t1,t2,t3)
t$success=log(10+Databag$view)
bagmodel=rpart(success~.data=trainbag,type="class")
pbag=predict(bagmodel,testbag,type="class")

##As most of the R code was done on console, code of parts of it such as regression/randomFOrest
##models have been omitted. Full R code can be submitted if need be. Due to time constraint
## we are only providing part of it .

