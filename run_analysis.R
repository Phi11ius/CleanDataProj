##STEP 0- READ THE DATA

  ###Training Data###
  train_vector<-read.table("UCI HAR Dataset/train/X_train.txt")
  train_label<-read.table("UCI HAR Dataset/train/Y_train.txt")
  train_subject<-read.table("UCI HAR Dataset/train/subject_train.txt")
  
  ###Test Data###
  test_vector<-read.table("UCI HAR Dataset/test/X_test.txt")
  test_label<-read.table("UCI HAR Dataset/test/Y_test.txt")
  test_subject<-read.table("UCI HAR Dataset/test/subject_test.txt")
  
  #Note- I ignore the Intertial Signals folder as it will not make it into my eventual tidy data set (no means or std)

  
#STEP 1- Merge the training and the test sets to create one data set.
  
vector<-rbind(train_vector, test_vector)
label<-rbind(train_label, test_label)
subject<-rbind(train_subject, test_subject)
  
#STEP 2- Extracts only the measurements on the mean and standard deviation for each measurement
  
features<-read.table("UCI HAR Dataset/features.txt")
meanstd<-grep("mean|std", features[,2])
vector<-vector[,meanstd]
names(vector)<-features[meanstd,2]
  
#STEP 3- Use descriptive activity names to name the activities in the data set.
  
activities<-read.table("UCI HAR Dataset/activity_labels.txt")
for(i in 1:6){
  label[,1]<-gsub(i, activities[i,2], label[,1])
}
  
##STEP 4- Appropriately label the data set with descriptive variable names. 
names(label)<-"Activity"
names(subject)<-"Subject"
cleanData<-cbind(subject, label, vector)
write.table(cleanData, "merged_clean_data")
  
##STEP 5- Create a tidy data set with the average of each variable for each activity and each subject.
tidyData<-matrix(nrow=180, ncol=81)
counter=1
  
for (i in 1:30){
  tmp<-subset(cleanData, Subject==i)
  for (j in 1:6){
    tmp2<-subset(tmp, Activity==activities[j,2])
    avg<-as.numeric(colMeans(tmp2[,3:ncol(tmp2)]))
    tmp3<-matrix(nrow=1, ncol=79)
    tmp3[1,]<-avg
    tmpRow<-cbind(tmp2[1,1:2],tmp3)
    for (k in 1:81){
    tidyData[counter,k]<-tmpRow[[k]]
    }
    counter<-counter+1
  }
}

colnames(tidyData)<-c("Subject", "Activities", names(vector))
  
write.table(tidyData, "tidyData.txt", row.names=F)
  
  
