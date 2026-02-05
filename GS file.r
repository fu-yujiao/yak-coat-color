#GS
setwd("C:/Users/FYJ130860/Desktop/gwas")
gd=read.table("GbyE.GD.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
id= gd[, 1]
gd_mat = gd[, -1]
n_col = ncol(gd_mat)
if (n_col %% 2 != 0) {
  stop("列数不是偶数，无法平均分割，请检查文件！")
}
split_point = n_col / 2
gd_left = cbind(ID = id, gd_mat[, 1:split_point])
gd_right = cbind(ID = id, gd_mat[, (split_point + 1):n_col])
write.table(gd_left, "GbyE.GD_left.txt", sep = "\t", quote = FALSE, row.names = FALSE)
write.table(gd_right, "GbyE.GD_right.txt", sep = "\t", quote = FALSE, row.names = FALSE)
#Build a kinship relationship matrix
gapit_functions = "C:/Users/FYJ130860/Desktop/gwas/gapit_functions.txt"
source(gapit_functions)
GD_left = read.table("GbyE.GD_left.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
GD_right = read.table("GbyE.GD_right.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
#Convert the genotype matrix into a numerical matrix
mat_left = as.matrix(GD_left[, -1])
rownames(mat_left) = GD_left$ID
mat_right = as.matrix(GD_right[, -1])
rownames(mat_right) = GD_right$ID
#Convert the genotype matrix into a numerical matrix
kinship_left = GAPIT.kinship.VanRaden(snps = mat_left)
kinship_right = GAPIT.kinship.VanRaden(snps = mat_right)
write.table(kinship_left, "Kinship_left.txt", sep = "\t", quote = FALSE, row.names = TRUE, col.names = NA)
write.table(kinship_right, "Kinship_right.txt", sep = "\t", quote = FALSE, row.names = TRUE, col.names = NA)
