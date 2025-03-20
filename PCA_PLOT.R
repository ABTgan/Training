#Libraries
install.packages("GGally")
library(GGally)
library(tidyverse)

# Set the working directory
setwd("C:/Users/abent/Documents/Coding")


##eigenvalues##

# Load the eigenvalues
eigenvalues <- read.table("pca.eigenval", header = FALSE)

# Calculate the proportion of variance explained
variance_explained <- eigenvalues$V1 / sum(eigenvalues$V1)

components_summary <- data.frame(
  Principal_Component = seq_along(variance_explained),  # Component numbers
  Variance_Explained = variance_explained,             # Proportion of variance explained
  Percentage_Explained = variance_explained * 100      # Converts to percentage
)

# Create a scree plot
plot(variance_explained, 
     type = "b", 
     xlab = "Principal Component", 
     ylab = "Proportion of Variance Explained", 
     main = "Scree Plot", 
     pch = 20, 
     col = "#EE82EE")




##eigenvectors##

# Load the eigenvectors
eigenvectors <- read.table("pca.eigenvec", header = FALSE)

# Remove the first column since its a duplicate
eigenvectors <- eigenvectors[, -1]

# Renaming the columns
colnames(eigenvectors) <- c("SampleID", paste0("PC", 1:10))

# Scatter plot of PC1 vs PC2
plot(eigenvectors$PC1, eigenvectors$PC2,
     xlab = "Principal Component 1",
     ylab = "Principal Component 2",
     main = "PCA Scatter Plot",
     col = "#4B0082",
     pch = 20)

# Adding labels to the scatter plot
text(eigenvectors$PC1, eigenvectors$PC2, 
     labels = eigenvectors$SampleID, 
     pos = 4, cex = 0.7)

# Scatter plot of PC3 vs PC4
plot(eigenvectors$PC3, eigenvectors$PC4,
     xlab = "Principal Component 3",
     ylab = "Principal Component 4",
     main = "PCA Scatter Plot",
     col = "#0000FF",
     pch = 20)

# Adding labels to the scatter plot
text(eigenvectors$PC3, eigenvectors$PC4, 
     labels = eigenvectors$SampleID, 
     pos = 4, cex = 0.7)

# Scatter plot of PC5 vs PC6
plot(eigenvectors$PC5, eigenvectors$PC6,
     xlab = "Principal Component 5",
     ylab = "Principal Component 6",
     main = "PCA Scatter Plot",
     col = "#008000",
     pch = 20)

# Adding labels to the scatter plot
text(eigenvectors$PC5, eigenvectors$PC6, 
     labels = eigenvectors$SampleID, 
     pos = 4, cex = 0.7)

# Scatter plot of PC7 vs PC8
plot(eigenvectors$PC7, eigenvectors$PC8,
     xlab = "Principal Component 7",
     ylab = "Principal Component 8",
     main = "PCA Scatter Plot",
     col = "#FFFF00",
     pch = 20)

# Adding labels to the scatter plot
text(eigenvectors$PC7, eigenvectors$PC8, 
     labels = eigenvectors$SampleID, 
     pos = 4, cex = 0.7)

# Scatter plot of PC9 vs PC10
plot(eigenvectors$PC9, eigenvectors$PC10,
     xlab = "Principal Component 9",
     ylab = "Principal Component 10",
     main = "PCA Scatter Plot",
     col = "orange",
     pch = 20)

# Adding labels to the scatter plot
text(eigenvectors$PC9, eigenvectors$PC10, 
     labels = eigenvectors$SampleID, 
     pos = 4, cex = 0.7)


# Pairwise scatter plots for all 10 principal components
pairs(eigenvectors[, 2:11], # Select only the PC columns
      main = "Pairwise Scatter Plots of Principal Components",
      pch = 20, col = "red")



# Create a pairs plot with GGally
ggpairs(eigenvectors[, 2:11], # Select PC columns
        title = "Pairwise Scatter Plots of Principal Components")

