library(data.table);library(reshape2)

## ----------------- Question -1 Merging Training and Test into one data set ----------------------

    # Setting my working directory on the directory that contains the datasets

setwd("./Coursera/DATA SCIENCE/COURSE 3  - Getting and Cleaning Data/Assignment W4/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/")

    # Getting all the data from the directory

features        <- read.table("./features.txt",header=FALSE)
activity_labels   <- read.table("./activity_labels.txt",header=FALSE)

subject_train    <-read.table("./train/subject_train.txt", header=FALSE)
X_train          <- read.table("./train/X_train.txt", header=FALSE)
y_train          <- read.table("./train/y_train.txt", header=FALSE)

subject_test    <-read.table("./test/subject_test.txt", header=FALSE)
X_test         <- read.table("./test/X_test.txt", header=FALSE)
y_test         <- read.table("./test/y_test.txt", header=FALSE)

    # First, creating a table for training and naming its variables

colnames(activity_labels)<-c("activity_ID","activity_TYPE")
colnames(subject_train) <- "ID"
colnames(X_train) <- features[,2] 
colnames(y_train) <- "activity_ID"

training <- cbind(subject_train,y_train,X_train)

    # Second, creating a table for test and naming its variables

colnames(subject_test) <- "ID"
colnames(X_test) <- features[,2]
colnames(y_test) <- "activity_ID"

test <- cbind(subject_test,y_test,X_test)

    # Third, merging the datasets Training and Test into one dataset "data"

dt_raw <- rbind(training,test)


## -------------- Question -2 Extracting only the measurements for the mean and std -----------

dtExtract <- dt_raw[grepl("activity_ID|ID|mean|std",colnames(dt_raw))]


## -------------- Question -3 Naming activities with activity labels -------------------------

dtDescrip <- merge.data.frame(activity_labels,dtExtract,by="activity_ID")


## -------------- Question -4 Labelling "dtDescrip" with descriptive variable names ----------------

    # Acc replaced with Accelerometer

names(dtDescrip) <- gsub("Acc","Accelerometer", names(dtDescrip))

    # Gyro replaced with Gyroscope
names(dtDescrip) <- gsub("Gyro","Gyroscope", names(dtDescrip))

    # BodyBody replaced with Bdy
names(dtDescrip) <-gsub("BodyBody","Body", names(dtDescrip))

    # Mag replaced with Magnitude
names(dtDescrip) <-gsub("Mag","Magnitude", names(dtDescrip))

    # f replaced with Frequency
names(dtDescrip) <-gsub("f","Frequency", names(dtDescrip))

    # t replaced with Time at the begining of the labels (e.g."t" in "Accelerometer" not replaced)
names(dtDescrip) <-gsub("^t","Time", names(dtDescrip))

    # Removing parentheses (e.g. parentheses in "mean()" and "std())

names(dtDescrip) <- gsub("\\(|\\)","",names(dtDescrip))


## ------------ Question -5 Creating a new dataset dtnew with average for each activity and ID ------

    # ID and activity_ID should be categorical variables: checking their classes and  converting them to factors

check <-str(dtDescrip)             

    # Converting ID and activity_ID to factors, as str shows that activity_ID and ID are integers

dtDescrip$activity_ID<- as.factor(dtDescrip$activity_ID); dtDescrip$ID<- as.factor(dtDescrip$ID)

    # creating a new dataset after reshaping it, and computing the mean for each ID and Activity

dtMelt <- melt(dtDescrip,id=c("activity_TYPE","ID"),
               measure.vars = names(dtDescrip)[4:length(names(dtDescrip))]) # Subsetting the variables

dtTidy <- dcast(dtMelt, ID + activity_TYPE ~ variable, mean)

write.table(dtTidy, file = "./dtTidy.txt")

