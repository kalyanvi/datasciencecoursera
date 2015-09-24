## Script for the course project(Getting and Cleaning data)

The script (run_analysis.R) will first set the working directory to the location where the common files(features,activity labels) are present. It will read these data and stores them in local variables. Then the script reads training data, subject data and activities and loads them together (cbind) into a dataset. Then it does the same for the test data.
It then merges(rbind) the training and test datasets to get the complete dataset. It then uses the grep function to only retrieve the required fields(mean/std). It then subsets the fully merged dataset to get only the required column data. It then uses the gsub function to remove the unwanted characters from the names of the subsetted dataset. Finally the script uses the group_by function from the dplyr package to get the mean of all the variables for each subject and activity and writes it into a dataset.


## Code book

### Variables used in the script run_analysis.R


* features - This stores all the feature variables.
* featvec - This stores only the variable names. This will be used to set the names of the main dataset.
* actlabels - This stores the various activities(Walking, Sitting etc) performed by volunteers.
* subject - This stores the training subjects/volunteers numbered randomly between 1 and 30.
* trndata - This stores the training data from the sensors converted to all the features
* activity - This stores the activity associated with each record of the training dataset.
* actdata - This stores the joined data of activities and labels for training data so that each activity can be understood with the name.
* trndatafnl - This stores the complete training data with its associated subjects/volunteers and activities(walking etc)
* subjecttst - This stores the test subjects/volunteers numbered randomly between 1 and 30.
* tstdata - This stores the test data from the sensors converted to all the features
* activitytst - This stores the activity associated with each record of the test dataset.
* actdatatst - This stores the joined data of activities and labels for test data so that each activity can be understood with the name.
* tstdatafnl - This stores the complete test data with its associated subjects/volunteers and activities(walking etc)
* data - This stores the merged training and test datasets.
* cols - This stores only the required(mean,std) fields from the names/column names of the merged dataset.
* colsfinal - This stores the cols plus subject and activity.
* datafnl - This stores the completed data for the fields containing mean/std in the field names.
* datatidy - This stores the final data (mean of each measure group by activity and subject). 
