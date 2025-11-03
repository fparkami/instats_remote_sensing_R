# This code will be used to calculate the amount of biomass of plants

library(terra)
library(imageRy)

# Listing images 
im.list()

# Importing the image -- this is from inside the package, from outside we should use rast
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")

# the image of vegetation is red, so the NIR inferared is on top of the red:
# NIR = band 1 (first component of the RGB) -- this is the most important one
# red = band 2
# green = band 3

# to flip the image
m1992f <- flip(m1992)
plot(m1992f)

# Another image
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

# to see the details of the images we just use their names
m1992
m2006

# building the multiframe - put 1 image beside another
par(mfrow = c(1 , 2))
plot(m1992)
plot(m2006)

# making rgb images
im.plotRGB (m1992, r = 1, g = 2, b =3, title = 'Mattogrosso 1992')  #creates the exact same red image
im.plotRGB (m2006, r = 1, g = 2, b =3, title = 'Mattogrosso 2006')  #creates the exact same red image

# Healthy vegetation appears bright red (since NIR is displayed in the red channel).
# Urban areas and soil appear gray or brown.
# Water appears dark or black (it absorbs NIR).

# We can move the NIR to the green component, puts the NIR on top of the green component, makes all vegetations green
# Here bare soil is shown by violet
im.plotRGB (m1992, r = 2, g = 1, b =3, title = 'Mattogrosso 1992') 
im.plotRGB (m2006, r = 2, g = 1, b =3, title = 'Mattogrosso 2006') 

# moving NIR on top of the blue component
# while on the first one the river is yellow, on the second one the river is blue
# that is because the water on the first one is not pure water but has a lot of soil in it
im.plotRGB (m1992, r = 2, g = 3, b =1, title = 'Mattogrosso 1992') 
im.plotRGB (m2006, r = 2, g = 3, b =1, title = 'Mattogrosso 2006') 

# Calculating difference vegetation index - the difference btw the NIR and red
# If we run m1992, we will see the three layers of color in the description: matogrosso~2219_lrg_1, matogrosso~2219_lrg_2, matogrosso~2219_lrg_3 
# The first layer is the NIR, [] means I am subsetting the image, only retaining for example the first element
nir1992 <- m1992 [[1]] #OR m1992 $ matogrosso~2219_lrg_1
red1992 <- m1992 [[2]]

# Calculating difference vegetation index for 2006
nir2006 <- m2006 [[1]] 
red2006 <- m2006 [[2]]

#then we calculate the DVI, since we are using a mathematical formula and not a function, we use = instead of <-
dvi1992 = nir1992 - red1992
dvi2006 = nir2006 - red2006

plot(dvi1992)
plot(dvi2006)

# to close the current plotting window
dev.off()

# to put both plots in one place
par(mfrow = c(1, 2))
plot(dvi1992) #shows a lot of vegetation
plot(dvi2006) #most vegetation is destroyed

#NDVI: Why do we use NDVI?
# consider the example of a 3 bits image, it means that it ranges from 0-7. because it means 2 elevated at 3, so 8 potential values
dvi = nir - red = 7 - 0 = 7 #the max dvi
# an 8 bit image: range(0-255) -- because 2 is elevated by 8
dvi = nir - red = 255 - 0 = 255 #the max dvi

## these images cannot be compared because one is ranging to 7 and the other to 255
# bit is the amount of color a pixel can store
# the number of bits is called radiometric resolution
# there are 3 types of resolutions: spatial, spectral (the number of bands), and the radiometric resolution (the amount of bits)
## to be able to compare these images, we need to use the NDVI
# ndvi = dvi / (nir + red)  # this means we have normalized the dvi
# dvi = nir - red = 7 - 0 = 7
# ndvi = dvi / (nir + red) = 7 / 7 + 0 = 1   # it is ranging to 1 (from -1)

# dvi = nir - red = 255 - 0 = 255
# ndvi = dvi / (nir + red) = 255 / 255 + 0 = 1    # it is ranging to 1 (from -1)
 # when you look at the images, you see they are both from -200 to + 255 --> in this case they are both the same radiometirc so dvi is ok to use
# if not the same, we will use ndvi

ndvi1992 = dvi1992 / (nir1992 + red1992)
ndvi2006 = dvi2006 / (nir2006 + red2006)

plot(ndvi1992)
plot(ndvi2006)

# changing the palette using viridis package, we use inferno pallette #color blind people can see these colors
library(viridis)
plot(ndvi1992, col = inferno (100))
plot(ndvi2006, col = inferno (100))

plot(ndvi1992, col = inferno (3))  #these give rougher images
plot(ndvi2006, col = inferno (3))

# The imagery package has some functions for calculating dvi and ndvi -- im.dvi() and im.ndvi()
#  Nature does not follow geometrical lines -- fractal dimension
# for example fire does not move in a linear way, it moves fractically
# when red is lower than NIR --> it shows either bare soil or water
#Healthy vegetation:
    # NIR (near-infrared) reflectance → high
    # Red reflectance → low
→ That’s why NDVI = (NIR − Red) / (NIR + Red) gives high values for vegetation


