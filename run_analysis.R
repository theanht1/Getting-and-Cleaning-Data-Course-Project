library(plyr)

fileName = "getdata_projectfiles_UCI HAR Dataset.zip"

# Download and unzip files if necessary
if (!file.exists(fileName)) {
    url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(url, fileName, method = "curl")    
}

if (!file.exists("UCI HAR Dataset")) {
    unzip(fileName)
}

# Load data
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt")
testSet <- read.table("UCI HAR Dataset/test/X_test.txt")
testLabel <- read.table("UCI HAR Dataset/test/y_test.txt")

trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainSet <- read.table("UCI HAR Dataset/train/X_train.txt")
trainLabel <- read.table("UCI HAR Dataset/train/y_train.txt")

features <- read.table("UCI HAR Dataset/features.txt")
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")

# Step 1. 
# Merges the training and the test sets to create one data set.
dataSubject <- rbind(testSubject, trainSubject)
dataLabel <- rbind(testLabel, trainLabel)
dataSet <- rbind(testSet, trainSet)

# Step 2. 
# Extracts only the measurements on the mean and standard deviation 
# for each measurement.
meanStdFeatures <- grep("(mean|std)\\(\\)", features[, 2])
dataSet <- dataSet[, meanStdFeatures]

# Step 3. 
# Uses descriptive activity names to name the activities in the data set
dataLabel[, 1] <- activityLabels[dataLabel[, 1], 2]

# Step 4. 
# Appropriately labels the data set with descriptive variable names.
names(dataSubject) <- "subject"
names(dataLabel) <- "activity"
features[, 2] <- gsub("\\(\\)", "", features[,2])
names(dataSet) <- features[meanStdFeatures, 2]

# Step 5. 
# From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

data <- cbind(dataSubject, dataLabel, dataSet)
dataMean <- ddply(data, .(subject, activity), 
                  function(x) colMeans(x[, 3:ncol(data)]))

# write data
write.table(dataMean, "data.txt", row.names = FALSE)