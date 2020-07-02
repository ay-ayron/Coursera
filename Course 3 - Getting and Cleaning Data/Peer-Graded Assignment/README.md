# Getting and Cleaning Data Peer-Graded Assignment"

This is the course project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:

1. Initializes appropriate libraries for the script to function.
2. Downloads the dataset if it does not already exist in the working directory.
3. Loads the feature and activity info
4. Loads the subject, activity and measurements for both the training and test datasets and merges them into a single dataset with appropriate column names
5. Subsets the dataset selecting out only those measurements for means and standard deviations
6. Converts the activity and subject columns into factors
7. Cleans up the column names with more descriptive names
7. Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair

The end result is shown in the file tidydata.txt.