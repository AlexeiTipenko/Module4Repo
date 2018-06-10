install.packages('magick')
install.packages('magrittr')
install.packages('pdftools')
install.packages('tesseract')
library(magick) 
library(magrittr)
library(pdftools)
library(tesseract)

dest <- "/module2repo/war-diary-text-all"
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
  
  outfile <- paste(i,"-ocr.txt",sep="")
  cat(text, file=outfile, sep="\n")
})

text <- image_read("~/module2repo/war-diary/e001518029.jpg") %>% 
  image_resize("2000") %>% 
  image_convert(colorspace = 'gray') %>% 
  image_trim() %>% 
  image_ocr()
write.table(text, "~/e001518029.jpg.txt")

text <- image_read("~/module2repo/war-diary/e001518030.jpg") %>% 
  image_resize("2000") %>% 
  image_convert(colorspace = 'gray') %>% 
  image_trim() %>% 
  image_ocr()
write.table(text, "~/e001518030.jpg.txt")

# text <- image_read("~/module2repo/ocr-test/R_1.png") %>% 
#   image_resize("2000") %>% 
#   image_convert(colorspace = 'gray') %>% 
#   image_trim() %>% 
#   image_ocr()
# write.table(text, "~/R_1.txt")

# text <- image_read("~/module2repo/war-diary/e001518087.jpg") %>% 
#   image_resize("2000") %>% 
#   image_convert(colorspace = 'gray') %>% 
#   image_trim() %>% 
#   image_ocr()
# write.table(text, "~/R.txt")
