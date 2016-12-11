library(reshape2)

filename <- "getdata_dataset.zip"
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

labels <- read.table("UCI HAR Dataset/activity_labels.txt")
labels[,2] <- as.character(labels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

meanstd <- grep(".*mean.*|.*std.*", features[,2])
meanstd.names <- features[meanstd.names,2]
meanstd.names = gsub('-mean', 'Mean', meanstd.names)
meanstd.names = gsub('-std', 'Std', meanstd.names)
meanstd.names <- gsub('[-()]', '', meanstd.names)

train <- read.table("UCI HAR Dataset/train/X_train.txt")[meanstd.names]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

#creating the factor variable
allData$activity <- factor(allData$activity, levels = labels[,1], labels = labels[,2])
allData$subject <- as.factor(allData$subject)
melted <- melt(allData, id = c("subject", "activity"))

write.table(melted, "tidy.txt", row.names = FALSE, quote = FALSE)


