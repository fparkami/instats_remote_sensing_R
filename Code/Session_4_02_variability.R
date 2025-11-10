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

im.plotRGB(sent, r = 1, g = 2, b = 3)
