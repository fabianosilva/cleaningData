#Setting variables
dirbase<-"./UCI HAR Dataset/"

#Getting column/variable names (part of objective #4)
featuresData<-read.table(header = FALSE, file = paste(dirbase,"features.txt", sep = ""), sep = " ")
featuresV<-as.vector(fetures$V2)

#Reading Files to Variables
#Using col.names to achieve objective #4
xTrain<-read.table(paste(dirbase,"train/X_train.txt", sep = ""), col.names = features)
yTrain<-read.table(paste(dirbase,"train/y_train.txt", sep = ""), col.names = c("Label"))
subjectTrain<-read.table(paste(dirbase,"train/subject_train.txt", sep = ""), col.names = c("Subject"))

xTest<-read.table(paste(dirbase,"test/X_test.txt", sep = ""), col.names = features)
yTest<-read.table(paste(dirbase,"test/y_test.txt", sep = ""), col.names = c("Label"))
subjectTest<-read.table(paste(dirbase,"test/subject_test.txt", sep = ""), col.names = c("Subject"))

labelsAct<-read.table(paste(dirbase,"activity_labels.txt", sep = ""), col.names = c("IndexAct", "Description"))

#binding tables
#Cbind puts togheter all columns for all train and test files. 
#Merge adds meaningfull labels for activities (objective #3)
trainSet<-merge(cbind(xTrain,yTrain,subjectTrain),labelsAct, by.x="Label", by.y="IndexAct")
testSet<-merge(cbind(xTest,yTest,subjectTest),labelsAct, by.x="Label", by.y="IndexAct")

#Merging both data sets - Objetctve #1
fullDataSet<- rbind(trainSet,testSet)

#extracting the measurements on the mean and standard deviation for each measurement. 
valueMeans<-data.frame()
valueDeviations<-data.frame()

for(v in featuresV) {
  label<-gsub("[\\(\\),-]",".",v)
  valueMeans[1,label]<-sapply(fullDataSet[label],mean)
  valueDeviations[1,label]<-sapply(fullDataSet[label],sd)
}

#creating the tidy dataset
#First step creating aggregation
tidyData<-aggregate(fullDataSet[,"Subject"] ~ Subject+Description, data = fullDataSet, FUN="mean")

#reading all variables and creating mean for those
for(v in featuresV) {
  label<-gsub("[\\(\\),-]",".",v)
  tidyData[,label] <- aggregate( fullDataSet[,label] ~ Subject+Description, data = fullDataSet, FUN= "mean" )[,3]
}

write.table(tidyData, file = "tidyData.txt")