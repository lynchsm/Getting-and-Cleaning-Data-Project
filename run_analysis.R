library(dplyr)

filename <- "getdata_projectfiles_UCI HAR Dataset.zip"

# check for zipped data file
if (!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, filename, method="curl")
}  

# checks for file, and if not present, unzips data file
if (!file.exists("UCI HAR Dataset")) { 
    unzip(filename) 
}

##read in data and set col names
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

##bind all train & test datasets together
x<-rbind(x_test, x_train)
y<-rbind(y_test, y_train)
sub<-rbind(subject_test, subject_train)

##merge all datasets together
merged<-cbind(sub,x,y)

##select only subject, code, and cols w/ mean & std
df<-merged%>%select(subject, code, contains("mean"), contains("std"))

##add activites by code to df
df$code<-activities[df$code, 2]

##add descriptions to col names
names(df)[2] = "activity"
names(df)<-gsub("Acc", "Accelerometer", names(df))
names(df)<-gsub("Gyro", "Gyroscope", names(df))
names(df)<-gsub("BodyBody", "Body", names(df))
names(df)<-gsub("Mag", "Magnitude", names(df))
names(df)<-gsub("^t", "Time", names(df))
names(df)<-gsub("^f", "Frequency", names(df))
names(df)<-gsub("tBody", "TimeBody", names(df))
names(df)<-gsub("-mean()", "Mean", names(df), ignore.case = TRUE)
names(df)<-gsub("-std()", "STD", names(df), ignore.case = TRUE)
names(df)<-gsub("-freq()", "Frequency", names(df), ignore.case = TRUE)
names(df)<-gsub("angle", "Angle", names(df))
names(df)<-gsub("gravity", "Gravity", names(df))

##average of each variable by subject & activity
summary <- df %>%
    group_by(subject, activity) %>%
    summarise_all(funs(mean))%>%
    ungroup(summary)
write.table(summary, "Cleaned_Dataset.txt", row.names = F)

##clean up enviornment
rm(activities,features, merged, sub, subject_test, subject_train, x,x_test, x_train, y, y_test, y_train)
