# GettingAndCleaningData_CourseProj


In this repo, you should find 
	- a README (you're looking at it)
	- R Code to generate results: run_analysis.R
	- Codebook.md: To describe the contents of the output file




Note: run_analysis.R assumes the Samsung data is in your working directory and will
	- Read in and combine the data
	- Read in and apply variable labels
	- Drop extraneous columns (anything other the Mean amd Standard Deviation measures)
	- Read in and apply value labels to the Activity values
	- Summarize the data by Subject x Activity, aggregating as the mean of the various retained measures
	- Export the aggregated results
