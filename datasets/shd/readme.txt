********************************************************************************
DATA SET: Semeion Handwritten Digit Data
********************************************************************************

This is a famous data set published on

https://archive.ics.uci.edu/ml/datasets/Semeion+Handwritten+Digit

see link above for details

* Sample size: 1593

* Number of variables: 1 outcome variable + 256 features

* Container:  R data.frame named  'dat'

* Variables 
  dat[,1]       contains true classes, that is: digits = {0,1,...,9} 
  dat[i,2:257]	are colors of the 16x16 pixels recorded as black-white
                intensities for the i-th obseved sample (see note)

NOTE: in order to map correctly pixels into a raster image we need to know
how the 256 pixels are organized on the screen. Suppose we sample an image
of 3x3 = 9px. The values of the pixels are given as the vector 

x = c(1,2,3,4,5,6,7,8,9)

These px would be obe organized on the screen as row and column
pixels as follow  

3    6    9
2    5    8
1    4    7

In order to plot a samlple image from the handwritten digit from the data set
we would run the R command below. For example dat[1,-1]  is   1st sample of
the 16x16=256 pixels, while dat[1,1] is the true class (digit) underlying
this sample. We can look the image corresponding to dat[1,] as 

plot_bw_pixel(x = dat[1,-1] , row_px = 16 , col_px = 16)

The 'plot_bw_pixel'  function is fiven below:               

plot_bw_pixel <- function(x , row_px = 16 , col_px = 16, ...){
  x <- as.vector(x)
  if(is.list(x)){
    x <- unlist(x)
  }  
  mat <- matrix(x, nrow = row_px, ncol = col_px, byrow = TRUE)
  mat <- t(mat[row_px:1, ])
  image(mat, col = c(0,1),
        xaxt = "n",
        yaxt = "n",
        useRaster = TRUE
        , ...)
}



