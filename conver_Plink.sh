#!/bin/bash

cut -d' ' -f1-6  SNPs.txt > phen.txt
cut -d' ' -f7- SNPs.txt > myfile.txt

#sed 's/./& /g'  temp.txt > myfile.txt

sed 's/0/A A/g' myfile.txt > newfile.txt

sed 's/1/A B/g'  newfile.txt > myfile.txt

sed 's/2/B B/g'   myfile.txt > newfile.txt

sed 's/NA/0 0/g' newfile.txt >  myfile.txt


paste -d' ' <(cat phen.txt) <(cat myfile.txt) > geno.ped

rm myfile.txt newfile.txt phen.txt
