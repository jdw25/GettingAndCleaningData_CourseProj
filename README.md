# GettingAndCleaningData_CourseProj


In this repo, you should find 
<ul>
<li>a README (you're looking at it)</li>
<li>R Code to generate results: run_analysis.R</li>
<li>Codebook.md: To describe the contents of the output file</li>
</ul>




Note: run_analysis.R assumes the Samsung data is in your working directory and will
<ul>
<li>Read in and combine the data</li>
<li>Read in and apply variable labels</li>
<li>Drop extraneous columns (anything other the Mean amd Standard Deviation measures)</li>
<li>Read in and apply value labels to the Activity values</li>
<li>Summarize the data by Subject x Activity, aggregating as the mean of the various retained measures</li>
<li>Export the aggregated results</li>
</ul>