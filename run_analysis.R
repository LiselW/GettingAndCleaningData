#### Assignment getting and cleaning data####
setwd("C:/Users/310192577/Documents/Course/3_Getting and Cleaning data/getdata_projectfiles_UCI HAR Dataset/Data")
install.packages("dplyr")
library(dplyr)

#Import data sets
x_test<-read.table("X_test.txt",sep="")
x_train<-read.table("X_train.txt", sep="")
y_test<-read.table("y_test.txt",sep="")
y_train<-read.table("y_train.txt",sep="")
subject_test<-read.table("subject_test.txt", sep="")
subject_train<-read.table("subject_train.txt", sep="")

#import training sets
#read features
features <- read.table('./features.txt')

#read column names for x_train and x_test from features, and insert the column names for the other tables
colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"
colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

### Extract the measurements on the mean and standard deviation for each measurement

#Create a vector that contains TRUE if the feature name contains mean() (because there's also meanFreq) or std
subsetselect<-(grepl("mean[()]..",features[,2])|grepl("std..",features[,2])) # lists column numbers with mean and stdev

#Subset x_train and x_test to contain only variables containing the mean or stdev
x_trainsub<-x_train[,(subsetselect==TRUE)]
x_testsub<-x_test[,(subsetselect==TRUE)]

### Merge the training and the test sets to create one dataset
merge_train <- cbind(y_train, subject_train, x_trainsub) # Merges all train sets
merge_test <- cbind(y_test, subject_test, x_testsub) #Merges all test sets
datamerge<-rbind(merge_train,merge_test) #Merges the train and test merged tables

### Use descriptive activity names to name the activities in the dataset

#read activityID
activitylabel<-read.table('./activity_labels.txt')
colnames(activitylabel) <- c('activityId','activitytype')
activitynameddata<-merge(datamerge,activitylabel,by='activityId',all.x=TRUE)

### Create a second independent tidy data set with the average of each variable for each activity and each subject
meandata<-aggregate(activitynameddata[,3:59],list(activitynameddata$activitytype,activitynameddata$subjectId),mean) # creates a new dataset that contains the average for each variable for each activity and for each subject
colnames(meandata)[colnames(meandata)=="Group.1"]<-"activitytype"
colnames(meandata)[colnames(meandata)=="Group.2"]<-"subjectID"

write.table(meandata,"Tidydataset.txt",row.name=FALSE)
