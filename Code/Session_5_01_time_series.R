# time series analysis in R

library(terra)
library(imageRy)

im.list()

# Nitrogen dioxide NO2 is very important gas that impacts the environment
# this gas was considerably reduced in time of Covid-19
# https://www.esa.int/Applications/Observing_the_Earth/Copernicus/Sentinel-5P/COVID-19_nitrogen_dioxide_over_China
# the video on the link above shows this in China
# the EN data shows the European Nitrogen

EN01 <- im.import("EN_01.png")
EN01  #we can see that this is just an RGB output, there is no relationship with the original bands

plot(EN01 [[1]])

EN13 <- im.import("EN_13.png")
EN13
plot(EN13 [[1]])  #Shows how strong the red values are in different parts of the image.
plot(EN13 [[2]])  #Shows how strong the green values are in different parts of the image.
plot(EN13 [[3]])  #Shows how strong the blue values are in different parts of the image.

ENset <- c(EN01 [[1]], EN13 [[1]])
plot(ENset)  #EN01 shows a wide amount of nitrogen, while it decreases in the other one

# the first is from Jan and the 2nd from March
jan <- EN01 [[1]]
mar <- EN13 [[1]]

# making the difference btw Jan and Mar, it subsracts the pixels
diffEN = jan - mar            # we use = because it is math
plot (diffEN)    # the jan parts are green and the mar ones are white

# the greenland data are about iceland ice melt
# if you only put "greenland", it will bring all four greenland data, but if I use the specific name, then it will only show that one
gr <- im.import("greenland")
gr_1 <- im.import("greenland.2000.tif")

# let's do the mako legend for the color from viridis
library(viridis)
plot(gr, col = mako(100))

# now let's change to inferno
plot(gr, col = inferno(100))   #the very dark side shows low temperature --> showing the ice
#to better show that, see below
par(mfrow = c(1, 2))
plot(gr[[1]], col = inferno(100))
plot(gr[[4]], col = inferno(100))

#let's change the order
par(mfrow = c(2, 1))
plot(gr[[1]], col = inferno(100))
plot(gr[[4]], col = inferno(100))

#to better see the difference
difgr = gr[[1]] - gr[[4]]
plot(difgr)

#since it is still showing the par function, we will dev.off()
dev.off()
#and the above code again
#to better see the difference
difgr = gr[[1]] - gr[[4]]
plot(difgr)

# to show th frequencies of each image in time using ridgeline plot
ndvi <- im.import("NDVI_2020")
ndvi  #to see the info, it is showing 4 months, and we can see they are all named NDVI,NDVI, NDVI, NDVI. this is a problem 32:01



