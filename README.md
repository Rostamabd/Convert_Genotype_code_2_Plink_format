# Convert Genotype code (0,1 and 2) into Plink Format

**Author**: *Rostam Abdollahi-Arpanahi*

**Date**: May 26, 2020

-----

Preparation of genotype data for Genome-wide association studies and Genomic Selection is an unavoidable and time consuming step in genomic analysis. 

Genotype data usually come from the genotyping company or institutions in the lgen or SNP coding format.

Plink, GCTA, R are basically the basic programs for GWAS and Genomic Prediction. Here, I have provided a code in both R and shell for converting the genotype data fron SNP code (0=AA, 1=AB and 2=BB) to plink format. 

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

- Convert ASCII data to binary. Remember to use plink 1.07 version

```
module load plink
plink --file geno --sheep --make-bed --out wgas2
```

- Allele frequency calculation

```
plink --bfile wgas2 --nonfounders --freq --out freq1
plink --bfile wgas2 --nonfounders --hardy --out hwe1
```

- Quality Control

```
plink --bfile wgas2 --maf 0.01 --geno 0.05 --mind 0.05 --hwe 1e-6 --nonfounders --make-bed --out wgas3
```

- Single marker linear association analysis

```
plink --bfile wgas3 --assoc --adjust --out assoc1
```

- Extracting certain SNP and conducting association

```
plink --bfile wgas3 --recode --snp rs11204005 --out tophit
plink --file tophit --all --missing
plink --file tophit --hardy
```

- EMPIRICAL ASSESSMENT OF POPULATION STRATIFICATION

```
plink --bfile wgas3 --indep-pairwise 50 10 0.2 --out prune1
plink --bfile wgas3 --extract prune1.prune.in --genome --out ibs1
```

- Constraints on clustering, pairwise population concordance (ppc)

```
plink --bfile wgas3 --read-genome ibs1.genome --cluster --ppc 1e-3 --cc --mds-plot 2 --out strat1
```

## Contact Information

Please send your comments and suggestions to rostam7474 at gmail dot com