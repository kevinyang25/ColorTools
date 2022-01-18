# ColorTools
App can be found here: https://kevinyang.shinyapps.io/ColorTools/

`ColorTools` is a collection of three apps that analyze the colors present in jpg and png files.

Packages used include: colordistance, colorfindr, and countcolors

## Top Color

Upon uploading a jpg or png file, the most frequent colors will be shown as a bar graph below. The number of bars can be set with the sliding bar under "Top X Colors" which has a default of 10. The most frequent color can be removed from the bar chart with the checkbox below the slider.

More info on the main package `colorfindr` used here can be found at: https://cran.r-project.org/web/packages/colorfindr/colorfindr.pdf

## Color Clusters

This is similar to `Top Color` except the app outputs a "color palette" of an image using k-means clustering. The number of clusters can be determined by the slider.

More info on the main package `colordistance` used here can be found at: https://cran.r-project.org/web/packages/colordistance/vignettes/colordistance-introduction.html

## Spherical Color Highlighter

This app will highlight a chosen color or a chosen range of colors in a particular image. An image and a color (Default is white) is needed. The "Range" is determined by the "radius" slider where 0 looks for an exact color while a value >0 will consider a range of colors based on its hexadecimal value.

More info on the main package `countcolors` used here can be found at: https://cran.r-project.org/web/packages/countcolors/vignettes/Introduction.html
