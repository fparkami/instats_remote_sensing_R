# Multivariate analysis of remote sensing data
# in the previous section we chose band 1: nir <- [[1]], but how to choose the best band for calculation
# one method is PCA: Principal Component Analysis
# ?? here we use pairs(name of dataset), which shows correlation among bands
pairs(sent)
# the result shows nir as band 1, red is 2, and green is 3, but his image was different so the numbers might be different for me, since mine was RGB
# look at the band correlation between band 2 and 3, both in the graph and the 0.98 correlation

# the below provides the statistics and the imagesof each band
sentpca <- im.pca(sent)
# the variability is the first line for each component, I noticed that each time I run the code the results are different, ChatGPT mentioned perhaps it is because of 
# using random pixels
# the pc3 image has a lot of noise

# based on the images and the variability, the first one has the highest variability, so we choose that one
pc1 <- sentpca [[1]]
pc1sd <- focal (pc1, matrix (1/9, 3, 3), fun = sd)
plot(pc1sd)  #his was blue, mine was yellow redish
