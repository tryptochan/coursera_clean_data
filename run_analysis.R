#  1. Read and merge testing and training data sets
features <- read.table("UCI HAR Dataset/features.txt",
                       col.names=c("index", "measure"),
                       stringsAsFactors=F)
train_data <- read.table("UCI HAR Dataset/train/X_train.txt")
test_data <- read.table("UCI HAR Dataset/test/X_test.txt")
train_label <- read.table("UCI HAR Dataset/train/y_train.txt")
test_label <- read.table("UCI HAR Dataset/test/y_test.txt")
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")

train <- cbind(train_subject, train_label, train_data)
test <- cbind(test_subject, test_label, test_data)
comb_data <- rbind(train, test)

#  2. Extracts only the measurements on the mean and standard deviation
#  for each measurement.
#  extract logical index, i.e. with mean() or std() in the names.
extract_idx <- grepl("^.+-(mean\\(\\)|std\\(\\))-?.*$", features$measure)
#  extract measurements, first two columns are subject and label
sub_data <- comb_data[, c(T, T, extract_idx)]

#  3. Convert to descriptive activity names
activity_label <- read.table("UCI HAR Dataset/activity_labels.txt",
                             stringsAsFactors=F)
sub_data[, 2] <- sapply(sub_data[, 2], function(x) {
                        # good that activity indexes equal row indexes
                        return(activity_label[x, 2]) 
                })

#  4. Label variable names with feature names
#  remove parentheses
var_names <- gsub("()", "", features[extract_idx, 2], fixed=T) 
#  remove duplicat 'Body' in last several feature names
var_names <- gsub("BodyBody", "Body", var_names, fixed=T) 
colnames(sub_data) <- c("Subject", "Activity", var_names)

#  5. Aggregate to produce a second data set of average values for
#  subject and activity
sub_data$Activity <- as.factor(sub_data$Activity)
sub_data$Subject <- as.factor(sub_data$Subject)
average_data <- aggregate(. ~ Subject+Activity, FUN=mean, data=sub_data)
write.table(average_data, "clean_data.txt", row.names=F)
