complete <- function(directory, id = 1:332) {
	# Inputs: directory where files are found
	#         vector of stations to look for
	#
	# Outputs: a data frame with observations per station
	
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
    
    for (i in id) {
    		# First-time read needs to create the data
    		if (!exists("pollution_data")) {
    			pollution_data <- read.csv(file_list[i])
    		} else {
    			file_data <- read.csv(file_list[i])
    			pollution_data <- rbind(pollution_data,file_data)
    		}
        }
    # Restore working directory
    setwd(cwd)

	# Extract the desired pollutant from sensors    
    obs_data <- data.frame()
    complete_obs <- complete.cases(pollution_data)
    pollution_nona <- pollution_data[complete_obs,]
    for (station in id) {
    	num_obs <- nrow(pollution_nona[pollution_nona$ID %in% station,])
    	obs_data <- rbind(obs_data,c(station,num_obs))
    }
    names(obs_data) <- c("id","nobs")

	obs_data
}