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
nir <- m1992 [[1]]




