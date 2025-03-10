# Ausgabe in Markdown und PDF Dateien umleiten
# Quelle: https://stackoverflow.com/questions/34875953/how-to-save-output-to-a-file-in-r
run_script <- function(filename) {
  sourcefilename <- paste0(filename, ".R")
 
  destFilename <- paste0(filename, ".md")
  destFilename <- file.path(getwd(), "../Output", destFilename)
  
  pdfFilename <- paste0(filename, ".pdf")
  pdfFilename <- file.path(getwd(), "../Output", pdfFilename)
  
  pdf(pdfFilename, width = 8, height = 6)
  sink(destFilename)
  source(sourcefilename, echo=TRUE, max.deparse.length=1024)
  sink()
  dev.off()
}

