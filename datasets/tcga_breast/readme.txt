********************************************************************************
			      TCGA BREAST CANCER DATA
********************************************************************************

Data measuring gene expressions on patients affected by breast cancer. The data
set is obtained from the Genomic Data Commons portal (TCGA) at

                         https://portal.gdc.cancer.gov/

The original data contained about 16000 genes. The present file contains a subset
of them obtained by applying the filtering method  reported in Wang et al. (2014),
and Coretto et al. (2018). 


* Sample size: 105 (patients)

* Number of variables: 3563 (genes)

* Container:  R data.frame named  'dat'

* Variables / Features
  `dat[,k]` = gene expression levels for gene `colnames(dat)[k]`
  


References

Wang, B., Mezlini, A. M., Demir, F., Fiume, M., Tu, Z., Brudno, M., Haibe-Kains,
B., and Goldenberg, A. (2014). Similarity network fusion for aggregating data types
on a genomic scale. Nature methods, 11(3), 333–337.

P. Coretto, A. Serra and R. Tagliaferri (2018). Robust clustering of noisy
high-dimensional gene expression data for patients subtyping.
Bioinformatics, Vol. 34(23), pp. 4064–4072.

A. Serra, P. Coretto, M. Fratello, and R. Tagliaferri (2018). Robust and sparse
correlation matrix estimation for the analysis of high-dimensional genomics data.
Bioinformatics, Vol. 34(4), pp. 625-634
