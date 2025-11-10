# How to measure spatial variability (diversity or heterogeneity) 
# if there is variability, it means there are several niches for wildlife to live in
# We expect the higher variability, the higher the biodiversity (plants?) -- this is spectral variation hypothesis

library(imageRy)
library(terra)

im.list()
sent <- im.import("sentinel.png")   #not sure why, but the instructor's code shows three bands, but mine is only one picture

# NIR = band 1
# red = band 2
# green = band 3

im.plotRGB(sent, r = 1, g = 2, b = 3, title = "Similaun")  #he used this code, but mine was already RGB
# the red part shows the vegetation, the dark red shows woodlands
# the light blue shows bare soil and the white is snow

dev.off()

# let's put the NIR on top of the green component, the vegetation becomes green
im.plotRGB(sent, r = 2, g = 1, b = 3, title = "Similaun")

# now let's put the NIR on top of blue
im.plotRGB(sent, r = 3, g = 2, b = 1, title = "Similaun")

# Calculating the Standard Deviation
# It can only be on top of a single layer, so we should choose
# select the first layer of that raster.
nir <- sent[[1]]

# the focal function calculates a certain statistics on top of an image, here the image is nir, fun = sd means function is standard deviation
# sd3 means we are using a 3 by 3 window, remember NOT to call anything sd, because it will be confused
sd3 <- focal (nir, matrix (1/9, 3, 3), fun = sd)
plot(sd3)

## Why your map is yellow–pink and your instructor’s is blue–purple
# In your version of terra, plot() is using the default terrain-like palette (warm browns → yellows → greens).
# In your instructor’s version of terra / imageRy, plot() used the viridis (mako/turbo) palette, which has blue → purple → cyan tones.

## Exercise: calculate the standard deviation with a moving window of 7x7 pixel
# A 7×7 window means that for each pixel, the algorithm looks at the 49 neighboring pixels around it
# So instead of calculating the standard deviation using all pixels in the whole image, we calculate it locally, around each pixel.
# We take all 49 values in that block and compute the standard deviation of those 49 numbers.
# Then we slide the window one pixel over, and do it again.
# This is why it is called a moving (or sliding) window.

sd7 <- focal(nir, matrix (1/49, 7, 7), fun = sd)
plot(sd7)
# In the one 7x7 it becomes a bit blair

par(mfrow = c(1, 2))
plot(sd3)
plot(sd7)

# Think of sd3 as zooming in:
# 🔎 You see small bumps, cracks, and pixel-level variation.
# Think of sd7 as zooming out:
# 🌍 You see broad shapes, patterns, and terrain regions.
## there is no perfect window dimensions. it depends on whether you want to look at the details or not.
