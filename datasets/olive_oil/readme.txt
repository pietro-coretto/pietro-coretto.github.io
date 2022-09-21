********************************************************************************
DATA SET: Olive Oil
********************************************************************************
Data measuring the composition of eight fatty acids found by lipid fraction
sampled on Italian olive oils. The data come from three macro-regions divided
further in 9 smaller areas (see below).

This is data set has been obtained from the GGobi software (Swayne et al.,
2006). We processed that data set in order to obtain an R data.frame format
for teaching purposes.

* Sample size: 572

* Number of variables: 10

* Container:  R data.frame named  'dat'

* Variables / Features
  dat[,1]       categorical variable indicating regions (macro level)
  dat[,2]       categorical variable indicating areas of region (micro level)
  dat[,3:10]	10 variables measuring the composition of 8 fatty acids



References


Forina, M., Armanino, C., Lanteri, S. and Tiscornia,
E. (1983). Classification of olive oils from their fatty acid composition. In
Food Research and Data Analysis, pp. 189-214. Applied Science Publishers,
London.

Forina, M. and Tiscornia, E. (1982). Pattern recognition methods in the
prediction of Italian olive oil origin by their fatty acid content. Annali di
Chimica 72, 143-155.

Swayne, D.F., Cook, D., Buja, A., Lang, D.T., Wickham, H. and Lawrence,
M. (2006). GGobi Manual. Sourced from www.ggobi.org/docs/manual.pdf.

