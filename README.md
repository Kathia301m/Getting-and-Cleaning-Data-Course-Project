# Getting and Cleaning Data Project

The goal of this project is (1) to get raw data from the “Human Activity Recognition Using Smartphones” Dataset, and clean them in order to get eventually tidy data. To do so, an R script called run_analysis.R has to be created with the following steps:

1.	Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement.
3.	Uses descriptive activity names to name the activities in the data set
4.	Appropriately labels the data set with descriptive activity names.
5.	Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Prerequisites

Two packages were used:
* `<data.table>` for question .1: getting the data set before merging training and test datasets. 
* `<reshape2>` for question. 5: melting and casting

## Running the code 

To run the code, you need to:

1. Download and load the dependencies mentioned above
2.	Download the datasets from the link provided on your computer
3.	Set your working directory on the directory that contains the folder **UCI HAR Dataset**
4.	Run the `<source("run_analysis.R")>` that will generate the text file containing the tidy data on your working directory.




