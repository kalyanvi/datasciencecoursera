library(plyr)
library(dplyr)

setwd("C:/Kalyan/Coursera/Getting and cleaning data/Course project/UCI HAR Dataset/") #Setting the working directory to locate features,activity label files.

features <- read.table("features.txt",header=FALSE,stringsAsFactors=FALSE) # - Reading the entire features data into the variable.
featvec <- features[,2] # Reading only the field names, so that they can be set as column headers.

actlabels <- read.table("activity_labels.txt",header=FALSE,stringsAsFactors=FALSE) # Reading the activity labels
names(actlabels) <- c("activity","activitylabel") # Setting names of the activity labels

#-----------------------------------------------------------------------------------------
# Start of reading and processing the training data.

setwd("C:/Kalyan/Coursera/Getting and cleaning data/Course project/UCI HAR Dataset/train") #Setting the working directory to locate training data.

subject <- read.table("subject_train.txt",header=FALSE,stringsAsFactors=FALSE) # Reading training data subjects.
names(subject) <- c("subject")

trndata <- read.table("X_train.txt",header=FALSE,stringsAsFactors=FALSE) # Reading training data.
names(trndata) <- featvec

activity <- read.table("y_train.txt",header=FALSE,stringsAsFactors=FALSE) # Reading the activities(Standing, walking etc of training dataset)
names(activity) <- c("activity")


actdata <- join(activity,actlabels,by="activity",match="all") # Joining activities to labels. 

trndatafnl <- cbind(subject,actdata,trndata) # Column merging the training data to the activity(Standing, walking) and the Subject (person)
#print(head(trndatafnl[,1:10]))

#-----------------------------------------------------------------------------------------
# Start of reading and processing the test data.

setwd("C:/Kalyan/Coursera/Getting and cleaning data/Course project/UCI HAR Dataset/test")

subjecttst <- read.table("subject_test.txt",header=FALSE,stringsAsFactors=FALSE)
names(subjecttst) <- c("subject")

tstdata <- read.table("X_test.txt",header=FALSE,stringsAsFactors=FALSE) # Reading the test data.
names(tstdata) <- featvec

activitytst <- read.table("y_test.txt",header=FALSE,stringsAsFactors=FALSE) # Reading the activities(Standing, walking etc of test dataset)
names(activitytst) <- c("activity")


actdatatst <- join(activitytst,actlabels,by="activity",match="all")

tstdatafnl <- cbind(subjecttst,actdatatst,tstdata) # Column merging the test data to the activity(Standing, walking) and the Subject (person)
#print(head(tstdatafnl[,1:10]))

#-----------------------------------------------------------------------------------------
# Merging the training and test data

data <- rbind(trndatafnl,tstdatafnl) # This will merge the training and test data sets.

cols <- grep("mean|std",names(data)) # Locating the fields containing only the mean and standard deviation

colsfinal <- c(1,3,cols)

datafnl <- data[,colsfinal] # Subsetting the required mean and standard deviation columns from the entire dataset

names(datafnl) <- gsub("\\()","",names(datafnl)) # Removing "()" from the column names
names(datafnl) <-gsub("-","",names(datafnl)) # Removing "-" from the column names
names(datafnl) <- tolower(names(datafnl)) # Converting column names to all lower case.

#-----------------------------------------------------------------------------------------
# Selecting the required data by performing mean of the respective variables group by activity, subject.

setwd("C:/Kalyan/Coursera/Getting and cleaning data/Course project/")

datatidy <- group_by(datafnl, subject, activitylabel) %>% summarise_each(c("mean")) # Performing mean of the measurements group by subject and activity.
write.table(datatidy,file="cleandata.txt",row.names=FALSE,col.names=TRUE) #Writing the dataset.

