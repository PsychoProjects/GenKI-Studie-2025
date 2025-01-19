
run_script <- function(filename) {
  sourcefilename <- paste0(filename, ".R")
 
  destfilename <- paste0(filename, ".md")
  destfilename <- file.path(getwd(), "../Output", destfilename)
  
  print(destfilename)
  
  sink(destfilename)
  source(sourcefilename, echo=TRUE, max.deparse.length=1024)
  sink()
}

