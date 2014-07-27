#Repository Structure

This repository only contains a single R script which will manipulate all data.

##Getting datafiles

Prior to running the script you should download the data file. You may use the following link:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Once downaoaded the file has to be unzipped.

##Configuring scripts

The script has to be configured with the "base directory" for the data file. For that you should change the following line:

  ````
  dirbase<-"./UCI HAR Dataset/"
  ````

In this case the dataset was unzipped inset the working directory and both subdirs, test and train, will be under the dirbase.
