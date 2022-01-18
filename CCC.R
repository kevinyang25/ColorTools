library(colordistance)
library(plot.matrix)
kcolor <- function(pic, num) {
  k <- getKMeanColors(pic,n=num)
  plot(
    matrix(rgb(k$centers), nrow = ceiling(num / 5)),
    axis.col = NULL,
    axis.row = NULL,
    xlab = '',
    ylab = '',
    main = 'Color Cluster Centers',
    col = rgb(k$centers),
    key = NULL,
    border = NA,
    digits = 7,
    na.col='black'
  )
}
