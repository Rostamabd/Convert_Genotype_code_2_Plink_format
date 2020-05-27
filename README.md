# Convert Genotype code (0,1 and 2) into Plink Format

**Author**: *Rostam Abdollahi-Arpanahi*

**Date**: May 26, 2020

-----

Preparation of genotype data for Genome-wide association studies and Genomic Selection is an unavoidable and time consuming step in genomic analysis. 

genotyping data usually come from the genotyping company or institauation in the lgen or SNP coding format.

Plink, GCTA, R are basically the basic programs for GWAS and Genomic Prediction. Here I have provided a code in both R and shell for converting the genotype data fron SNP code (0=AA, 1=AB and 2=BB) to plink format. 

## 1) Convert from 0, 1 and 2 to Plink Format Using R

```
git clone https://github.com/Rostamabd/Convert_Genotype_code_2_Plink_format.git
module load R
R
source("Read_Data.R")
```

In case there is missing genotypes within the genotype file, it can be imputed using the above script. It replace the missing genotype with the mean of certain genotype (approximately most frequent allele)

## 2) Convert from 0, 1 and 2 to Plink Format Using Shell

```
chmod 775 conver_Plink.sh
./conver_Plink.sh
```

If your data are in AIPL format (0125311222001235...) which means SNP genotypes codes are sticking together, you should add space between genotypes using the below command. 

It is assumed the first column of genotype data is "Animal IDs" and the second column is the genotype data.

```
cut -d' ' -f1  SNPs.txt > ID.txt
cut -d' ' -f2 SNPs.txt > temp.txt

sed 's/./& /g'  temp.txt > myfile.txt
```

Then, you can follow the rest of preparation similar to R and shell scripts.

## 3) Genome-wide Association Analysis using Plink

Under construction

## Contact Information

Please send your comments and suggestions to rostam7474 at gmail dot com