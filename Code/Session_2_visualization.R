# R code for visualizing satellite data

# Packages needed
library(terra)
library(imageRy)

# Packages needed
install.packages("terra")
#to install imageRy, you need to get it from github, therefore, you need to install devtools first
install.packages("devtools")



library(devtools)
#devtools related functions to install packages from Github
install_github("ducciorocchini/imageRy")

#once imageRy has been installed by the devtools package,, it can be recalled by the library

library(terra)


library(imageRy)

# Listing data
im.list()  #lists all of the data

#Importing Band 2
b2 <- im.import("sentinel.dolomites.b2.tif")

#install viridis package
install.packages("viridis")
library(viridis)
plot(b2, col = magma(100))
plot(b2, col = magma(150))     

#Info about the band
b2
