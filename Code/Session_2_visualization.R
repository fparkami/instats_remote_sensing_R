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

# Listing data - All imageRy functions start with im
im.list()  #lists all of the data

#Importing Band 2
b2 <- im.import("sentinel.dolomites.b2.tif")

#install viridis package
install.packages("viridis")
library(viridis)
plot(b2, col = magma(100))
plot(b2, col = magma(150))     

#Info about the band -- b3 is green, b4 is red, b8 is NIR(near inferared)
b2

#We will now go band by band and then how to import them all together
# importing the other bands (that can be seen from the list above -- the im.kist() code
b3 <- im.import("sentinel.dolomites.b3.tif")
b4 <- im.import("sentinel.dolomites.b4.tif")
b8 <- im.import("sentinel.dolomites.b8.tif")

# Plotting one band beside the other/plotting them on a multiframe (mf) -- using 1 row and 2 columns
# when we bring "row" it means we will first say the number of rows then the columns
par(mfrow = c(1,2))
plot(b4)
plot(b8)

# Exercise: Plot all the 4 bands together with 2 rows and 2 columns
par(mfrow = c(2,2))
plot(b2)
plot(b3)
plot(b4)
plot(b8)

# stack all four bands together -- this is actually an easier way to do it compared to the previous one--the same result
sentstack <- c(b2, b3, b4, b8)
sentstack
plot(sentstack)

# Deleting the previous graph -- we don't want to have them because we are having a new one?
dev.off()

# Plotting with RGB Scheme = in color
# The RGB is the stacking of blue, red, and green on each other. But here we have 4 bands, there is a NIR band as well. So, what is the solution?
# Building a natural color image -- putting the name of the satellite and then the element
# Image: sentstack
# 1st element of the image: blue (band 2)
# 2nd element of the image: green (band 3)
# 3rd element of the image: red (band 4)
# 4th element of the image: NIR (band 8)

#Just consider the elements of the image (array)




