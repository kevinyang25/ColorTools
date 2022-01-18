library(countcolors)
library(jpeg)
library(png)
sphereHighlighter <- function(pic, pictype, color, radi, colreplace) {
  if (pictype == 1) {
    picture <- readJPEG(pic)
  }
  else{
    picture <- readPNG(pic)[,,1:3] # Check "Raster Images"
  }
  sphericalRange(
    picture,
    center = col2rgb(color) / 255,
    radius = radi / 255,
    target.color = colreplace
  )
}