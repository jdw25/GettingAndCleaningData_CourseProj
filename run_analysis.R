# You should create one R script called run_analysis.R that does the following. 
# 1 Merges the training and the test sets to create one data set.
# 2 Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3 Uses descriptive activity names to name the activities in the data set
# 4 Appropriately labels the data set with descriptive variable names. 
# 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#####


# ->1 Merge the relevant files
# -> 1_i read in the test and train data set files into R
library(readr)
train <- read_table(".\\UCI HAR Dataset\\train\\X_train.txt", col_names=F)
test  <- read_table(".\\UCI HAR Dataset\\test\\X_test.txt", col_names=F)

# -> 1_ii Read in the Subject and Activity info
# in prep for "merge": in alignment w principles of tidy data, combining these "down" rather than "across", with labels to identify train vs test
train_subj <- read_table(".\\UCI HAR Dataset\\train\\subject_train.txt", col_names=F)
train_activity <- read_table(".\\UCI HAR Dataset\\train\\y_train.txt", col_names=F)
train <- cbind(Dataset="train", train_subj,train_activity,train) 
rm(train_subj,train_activity)

test_subj <- read_table(".\\UCI HAR Dataset\\test\\subject_test.txt", col_names=F)
test_activity <- read_table(".\\UCI HAR Dataset\\test\\y_test.txt", col_names=F)
test <- cbind(Dataset="test", test_subj,test_activity,test)
rm(test_subj,test_activity)

# -> 1_iii combine the two sets, going down.
full <- rbind(train, test)
rm(train,test)

# -> 1_iv Add Labels
names(full)[2:3] <- c("Subject","Activity")
labels <- read.table(".\\UCI HAR Dataset\\features.txt") #readr function acts weird on this,revert to Base.
names(full)[4:length(names(full))] <- as.character(labels[,2])
rm(labels)


# 2: Extract only the measurements on the mean and standard deviation for each measurement
#names(full[,grep("mean()|std()",names(full))]) #still returning meanFreq...make sure to escape the '(' and ')'
#i.e., names(full[,grep("mean\\(\\)|std\\(\\)",names(full))])
full_short <- 
    cbind(full[1:3],
        full[,grep(c("mean\\(\\)|std\\(\\)"),names(full))]
        )
rm(full)

# 3: Use descriptive activity names to name the activities in the data set
# so: transform the Activity variable to a Factor variable, based on .\temp\UCI HAR Dataset\activity_labels
activity_labels <- read.table(".\\UCI HAR Dataset\\activity_labels.txt")
full_short$Activity <- factor(full_short$Activity,
                              levels = activity_labels[,1],
                              labels = activity_labels[,2]
                              )
rm(activity_labels)

                               
# 4: Appropriately label the data set with descriptive variable names. 
# (Assume this was done sufficiently with the labels imported earlier)


                                  
# 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject.
library(dplyr)
full_short %>%
    group_by(Subject,Activity) %>%
    select(-Dataset) %>%
    summarize_each(funs(mean)) -> full_short_aggregate


#EXPORT
write.table(full_short_aggregate,file=".\\export.txt", row.name=FALSE)
# reimport <- read.table(file=".\\export.txt", header=T)
#mis matches only on very small amounts -- this is rounding error

