README for the run_analysis.R script for the Getting and cleaning data course

In order to run the analysis:
1. Create a folder containing:
	x_train.txt
	y_train.txt
	subject_train.txt
	x_test.txt
	y_test.txt
	subject_test.txt
	features.txt
	activity_labels.txt
2. set directory to the folders containing data

The script performs the following actions:
1. Loads the datasets from the directory
2. Extracts the required columns of the mean and standard deviation for each measurement type
3. Merges the datasets on fitting dimensions
4. Names the measurements
5. Names the activity types
6. Calculates the average for each measurement type per activity type per subject
7. Stores the tidy dataset in Tidydataset.txt in the directory folder
