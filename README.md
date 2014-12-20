### Description
This is the course project for **Getting and Cleaning Data** on Coursera. The R script is written to get a clean data set for [*Human Activity Recognition Using Smartphones Data Set*](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) from UC Irvine Machine Learning Repository.

### Usage
Assuming the data set is decompressed under the working directory, just source the script in R.

    source("run_analysis.R")
  
It will merge the test and training sets and only extract the measurements on the mean and standard deviation for each measurement. After labeling activities and variables more descriptively, it will output a tiny data set that shows average values of each extracted measurement for each activity and each subject.