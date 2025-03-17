install.packages(c("vcfR", "adegenet", "ggplot2"))
library(vcfR)
library(adegenet)
library(ggplot2)

#read vcf file
vcf <- read.vcfR("C:/Users/abent/Desktop/HGDP_data/hgdp_wgs.20190516.full.chr21.vcf")

#convert to o genind Object
gen <- vcfR2genind(vcf)

# pca on genin object
pca <- scaleGen(gen, center = TRUE, scale = TRUE)
pca_result <- dudi.pca(pca, center = TRUE, scale = FALSE, scannf = FALSE, nf = 10)

#extracting results
eigenvalues <- pca_result$eig
pc_scores <- as.data.frame(pca_result$li)

#scree plot
var_explained <- eigenvalues / sum(eigenvalues)
scree_data <- data.frame(PC = 1:length(var_explained), VarExplained = var_explained)

scree_plot <- ggplot(scree_data, aes(x = PC, y = VarExplained)) +
  geom_bar(stat = "identity") +
  labs(title = "Scree Plot", x = "Principal Component", y = "Proportion of Variance Explained") +
  theme_minimal()

ggsave("scree_plot.pdf", plot = scree_plot, width = 8, height = 6)



