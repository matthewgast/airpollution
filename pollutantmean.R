pollutantmean <- function(directory, pollutant, id = 1:332) {
	# Inputs: directory where files are found
	#         pollutant, either "nitrate" or "sulfate"
	#         vector of stations to look for
	
	# Change to specified directory
	cwd <- getwd()
	newdir <- paste(cwd,directory,sep="/")
	if (file.exists(newdir)) {
		setwd(newdir)
	} else {
		print("ERROR: Directory does not exist!")
	}
	
	# Create list of files to be tested against
    file_list <- list.files(newdir,pattern="*.csv")
    
    for (filename in file_list) {
    		# First-time read needs to create the data
    		if (!exists("pollution_data")) {
    			pollution_data <- read.csv(filename)
    		} else {
    			file_data <- read.csv(filename)
    			pollution_data <- rbind(pollution_data,file_data)
    			rm(file_data)	
    		}
        }
    # Restore working directory
    setwd(cwd)

	# Extract the desired pollutant from sensors    
    pollution_vector <- pollution_data[pollution_data$ID %in% id, pollutant]
    
	mean(pollution_vector,na.rm=TRUE)
}