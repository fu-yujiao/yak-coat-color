setwd("C:/work")
myGD=read.csv("fmyGD.csv",head=T)
myGM=read.csv("fmyGM.csv",head=T)
myY=read.csv("fmyY.csv",head=T)
myCV=read.table("fmyCV.txt",head=T)
gd.taxa=as.character(myGD[,1])
gd.taxa <- revert_plink_names(gd.taxa)
y.taxa=as.character(myY[,1])
cv.taxa=as.character(myCV[,1])
cv.taxa=revert_plink_names(cv.taxa)
com.taxa=intersect(gd.taxa,y.taxa)
gd.index=match(com.taxa,gd.taxa)
y.index=match(com.taxa,y.taxa)
cv.index=match(com.taxa,cv.taxa)
myCV[,1]=cv.taxa
newY=myY[y.index,]
newCV=myCV[cv.index,]
myGD[,1]=gd.taxa
newGD=myGD[gd.index,]
newY[is.na(newY)]="NaN"
write.table(t(newGD[,-1]),paste("GbyE.yaks.dat",sep=""),row.names=F,col.names=F,quote = F)
write.table(myGM,paste("GbyE.yaks.map",sep=""),row.names=F,col.names=T,quote = F)
write.table(newCV,paste("GbyE.yaks.cov",sep=""),quote=F,row.names=F)
write.table(newY,paste("GbyE.yaks.txt",sep=""),quote=F,row.names=F)

#cd /Users/Documents/Data/706yaks
#./GbyE --gwas --file GbyE.yaks --numeric --interaction 2

setwd("C:/work2")
result=read.table(paste("GbyE_GWAS_result.txt",sep=""),head=T)
myY=read.table(paste("GbyE.yaks.txt",sep=""),head=T)
map=read.table(paste("GbyE.yaks.map",sep=""),head=T)
chr0=NULL
for(i in 1:2)
{
if(i==1)
{
m=0
}else{
m=max(chr0)
}
chr=map[,2]+m
chr0=cbind(chr0,chr)
}
chr0=as.numeric(chr0)
result[,2]=chr0
write.table(result,"GbyE_GWAS_result.map.txt",quote=F,row.names=F)
source("/Users/Documents/R/code/Manhattan_g&e.R")
GAPIT.Manhattan(GI.MP=result[,-c(1,4)],name.of.trait="GbyE",Name_environ=colnames(myY)[-1],Nenviron=(ncol(myY)-1))
