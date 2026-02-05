file_path = "C:/work2/gapit_functions.txt"
source(file_path)
setwd("C:/work2")
fmyGD = read.csv("fmyGD.csv", header = TRUE)#Genotype data file
colnames(fmyGD)[1] = "taxa"
fmyY = read.csv("fmyY.csv", header = TRUE)#phenotype data file
fmyCV = read.csv("fmyCV.csv", header = TRUE)#Age data fil
fmyGM = read.csv("myGMM2.csv", header = TRUE)#Chromosome data
gwas_results = GAPIT(
           Y = fmyY,   
           GD = fmyGD,
           GM = fmyGM,
           CV = fmyCV,
           PCA.total = 3,
           model = c("GLM" ,"MLM","MLMM","FarmCPU","Blink" ),
           Multiple_analysis = TRUE
)