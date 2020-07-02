#Below is a script that creates a tidy data set from 
#accelerometer measurements taken from a Samsung Galaxy S smartphone.

#A CodeBook.md is included to describe the variables, data and
#all transformations performed herein.

#A README.md is also included to explain how all of the scripts
#work and how they are connected.

#This script works by: 
#1) Merging the training and test sets to create one data set
#2) Extracts only the measurements on the mean and standard 
#deviation for each measurement.
#3) Uses descriptive activity names to name the activities in the data set
#4) Appropriately labels the data set with descriptive variable names.
#5) From the data set in step 4, creates a second, independent tidy data
#set with the average of each variable for each activity and each subject.

#Prepare libraries
library(dplyr)
library(plyr)

#Retrieve Data
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("UCI HAR Dataset")) {
  dir.create("rawdata")
  download.file(url, "./rawdata/data.zip", method = "curl")
  dateDownloaded1 <- date()
  unzip("./rawdata/data.zip")
}

#Read in all necessary data
#Read Features and Activity Labels
features <- read.table("./UCI HAR Dataset/features.txt")
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")

#Read Train Data
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
s_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

#Read Test Data
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
s_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

#Merge Training and Test Data
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
s_data <- rbind(s_train, s_test)

#Assign column names for x_data, y_data and s_data
names(x_data) <- features$V2
names(y_data) <- c("activity")
names(s_data) <- c("subject")

#Merge columns to get overall dataframe named data
data <- cbind(s_data, y_data, x_data)

#Find all mean and std for each measurement
subfeatures <- features$V2[grep("mean\\(\\)|std\\(\\)", features$V2)]
selectednames <- c("subject", "activity", subfeatures)

#Subset data to extract only mean and std measurements
data <- subset(data, select = selectednames)

#Name activities by descriptive activity name
data$activity <- factor(data$activity, levels = activities[,1], labels = activities[,2])

#Make Subject a factor
data$subject <- as.factor(data$subject)

#Clean up column names
names(data)<-gsub("^t", "time", names(data))
names(data)<-gsub("^f", "frequency", names(data))
names(data)<-gsub("Acc", "Accelerometer", names(data))
names(data)<-gsub("Gyro", "Gyroscope", names(data))
names(data)<-gsub("Mag", "Magnitude", names(data))
names(data)<-gsub("BodyBody", "Body", names(data))

#Make tidy data with averages
tidydata <- aggregate(. ~subject + activity, data, mean)
write.table(tidydata, file = "tidydata.txt", row.name = FALSE)
