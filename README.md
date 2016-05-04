# Getting and Cleaning Data - Course Project

This repository is the course project for the Getting and Cleaning Data Coursera course.

#### Data source
The data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Dataset: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#### How `run_analysis.R` works:

* Download and unzip the dataset if it is not in the working directory.
* Load data from test and train set.
* Load activity name and variable name.
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Replace activity column from number to name respectively.
* Label the data set with descriptive variable names.
* Create a tidy dataset that consists of the average of each variable for each activity of each subject.
* Export data to files.

The result is shown in `data.txt`