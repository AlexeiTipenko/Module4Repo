install.packages('magick')
install.packages('magrittr')
install.packages('pdftools')
install.packages('tesseract')
library(magick) 
library(magrittr)
library(pdftools)
library(tesseract)

dest <- "~/Dropbox/Year3/DIGH3814O/Module4Repo/TopicModeling_Tool/war-diary"
myfiles <- list.files(path = dest, pattern = "jpg", full.names = TRUE)

# improve the images
# ocr 'em
# write the output to text file

lapply(myfiles, function(i){
  text <- image_read(i) %>%
    image_resize("3000x") %>%
    image_convert(type = 'Grayscale') %>%
    image_trim(fuzz = 40) %>%
    image_write(format = 'jpg', density = '300x300') %>%
    tesseract::ocr()
  
  #outfile <- paste(i,".txt",sep="")
  #cat(text, file=outfile, sep="\n")
  write.table(text, "~/e001518030.jpg.txt")
})
