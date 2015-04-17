corr <- function(directory, threshold=0) {
	# Inputs: directory where files are found
	#         correlation threshold
	#
	# Outputs: a vector of correlations; if no monitors meet the requirement, vector of length 0
	# is returned
	
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
     
    corr_vect <- vector(mode="numeric")
    idx <- 1
    for (file in file_list) {
    	raw_obs <- read.csv(file)
    	complete <- complete.cases(raw_obs)
    	complete_obs <- raw_obs[complete,]
    	if (nrow(complete_obs) > threshold) {
    		correlate = cor(complete_obs["sulfate"],complete_obs["nitrate"])[1,1]
    		print(paste("Correlation for monitor ",file,"is ",correlate))
    		corr_vect[idx] <- correlate
    		idx <- idx + 1
    	}
    	
    }
    # Restore working directory
    setwd(cwd)
    
    corr_vect
}