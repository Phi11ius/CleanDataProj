# CodeBook

This Codebook describes my run_analysis.R code, the logic behind each step, and the data involved

# SUMMARY
I was given a lot of raw data describing statistics of users using a Samsung device measuring their movements. 
My job was to filter through the data in order to cleanse it, combine it, and tidy it up in a more refined format. 
This was accomplished in five stars:

	Step 1- Merge training and test sets
	Step 2- Extract only measurements involving mean and standard deviation
	Step 3- Replace activity numeric labels with descriptive labels
	Step 4- Label the data set with descriptive variable names
	Step 5- Create a set of tidy data
	
# PREPARATORY STEPS
I read the data into R. Note that the working directory should contain the UCI HAR Dataset folder

# STEP 1
The data was divided into training and test fields. I combined them. However, I left the labels, vectors, and subject fields seperate. 
This was in case I would have to separately deal with each one in a future step. 

# STEP 2
I use regex to go through the vectors file and extract only the fields with the words "mean" and "std" in them 
In this same step, I name each column as I was one line of code away (suggested as Step 4).

# STEP 3
I use the activities text file and regex to replace the numbers with the appropriate activity. 

# STEP 4
I use the names() function to label the remaining fields

# STEP 5
The first step was to finally combine all three data files I had been using. At this point, I use for loops
to iterate through the subjects and then the activities in order to combine the average for the variable fields. 
The final result is included in this repo as tidyData.txt.  

#Data


