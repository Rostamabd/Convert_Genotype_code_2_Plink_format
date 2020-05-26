rm(list=ls(all=TRUE))

### load the Input data by scan function. It is pretty fast
DF <- matrix(scan("SNPs.txt", n = 89*5006, what=numeric(0)), 89, 5006, byrow = TRUE)
head(DF[,1:20])

### Imput missing genotype

for (j in 7:ncol(DF)){
   DF[is.na(DF[, j]), j] <- round(mean(DF[,j], na.rm=TRUE),0)
}

### Check the genotype after imputation
head(DF[,1:20])

### Genotype file
gen <- DF[,7:ncol(DF)]

### phenotype data
phen <- DF[,1:6]

### convert genotype coding to plink format
gen[gen=="0"]<- "A A"
gen[gen=="1"]<- "A B"
gen[gen=="2"]<- "B B"
gen[gen=="NA"]<- "0 0"

dim(gen)
head(gen[,1:14])


### save data in plink format
gen2 <- cbind(phen,gen)
write.table(gen2,file="geno.ped",quote = F, sep = " ", eol = "\n", row.names = F, col.names = F)