#Getting and Cleaning Data Project

Submission for Getting and Cleaning Data course project. 

Dataset:
======================================
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Files:
======================================
CodeBook.md - a code book that describes the variables, data, and cleaning transformation preformed on the dataset

run_analysis.R - Script that performs the following functions to aggregate & clean the data:
1 Downloads & unzips the datafile 
2 Assigns each dataset to a variable 
3 Aggregates the dataset together
4 Subsets the columns for those that contain mean & standard deviation measurements 
5 Assigns activities to each row based on unique identifier
6 Gives each column a more descriptive name 
7 Groups dataset by activity and subject and provides an average for each column
8 Writes the summarized & cleaned dataset to working directory

Cleaned_Dataset.txt is the cleaned dataset after running the R script
