library(colorfindr)
maxColor <- function(pic, num, remotop) {
  par(las = 2)
  if (remotop == FALSE) {
    frame <- as.data.frame(get_colors(as.character(pic), top_n = num))
  }
  else {
    frame <- as.data.frame(get_colors(as.character(pic), top_n = num)[-1, ])
  }
  barplot(
    frame$col_freq,
    names.arg = frame$col_hex,
    col = frame$col_hex,
    main = "Most Frequent Colors in Image",
    ylab = "Frequency"
  )
}
