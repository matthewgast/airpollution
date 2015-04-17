pollutantmean <- function(directory, pollutant, id = 1:332) {
	# Inputs: directory where files are found
	#         pollutant, either "nitrate" or "sulfate"
	#         vector of stations to process
	#
	# Output: mean of pollutant type over specified sensors
	
	# Change to specified directory
	cwd <- getwd()
	newdir <- paste(cwd,directory,sep="/")
	if (file.exists(newdir)) {
		setwd(newdir)
	} else {
		print("ERROR: Directory does not exist!")
	}
	
	# Create list of files in the directory
    file_list <- list.files(newdir,pattern="*.csv")
    
    pollution_data <- data.frame()
    
    # Only read from files of interest
    for (filenumber in id) {
    	pollution_data <- rbind(pollution_data,read.csv(file_list[filenumber]))
    }
    # Restore working directory
    setwd(cwd)
	
	mean(pollution_data[,pollutant],na.rm=TRUE)
}