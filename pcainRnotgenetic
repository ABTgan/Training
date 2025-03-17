install.packages("corrr")
install.packages("ggcorrplot")
install.packages("FactoMineR")
install.packages("factoextra")
library('corrr')
library(ggcorrplot)
library("FactoMineR")
library(factoextra)


getwd()

#data
protein_data <- read.csv("protein_data.csv")
str(protein_data)

#getting rid of non-numerical extra data
numerical_data <- protein_data[, -1]
head(numerical_data)

#normalising
data_normalized <- scale(numerical_data)
head(data_normalized)

#correlation matrix
corr_matrix = cor (data_normalized)
ggcorrplot(corr_matrix)

#data.pca <- princomp(data_normalized)
data.pca <- prcomp(corr_matrix)
summary(data.pca)


#Scree plot
fviz_eig(data.pca, addlabels = TRUE)
# biplot of cols
fviz_pca_var(data.pca, col.var = "black")

#quality of represnetation of each variable
fviz_cos2(data.pca, choice = "var", axes = 1:2)

#biplot combined with cos2
fviz_pca_var(data.pca, col.var = "cos2",
             gradient.cols = c("black", "red", "orange", "yellow","green"),
             repel = TRUE)
