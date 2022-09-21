## =============================================================================
## Corso          ::   Analisi e Visualizzazione dei Dati [0212800004] / Parte I
## Cdl/Percorso   ::   Statistica per i Big Data (L41)
## Docente        ::   Pietro Coretto (pcoretto@unisa.it)
##
##
##  Argomenti:
##   * simmetria
##   * misure di simmetria
## =============================================================================



## Esploriamo la simmetria
## ***********************

## consideriamo il data set
## https://pietro-coretto.github.io/datasets/nls80/readme.txt
## 
load(url("https://pietro-coretto.github.io/datasets/nls80/nls80.RData"))
iq <- NLS80$iq


## Facciamo un primo summary numerico e grafico
summary(iq)

hist(iq)

plot(ecdf(iq))


## Calcoliamo il coefficiente gamma_1 di Pearson
z_iq <- { iq - mean(iq) } / sd(iq)
gamma_1 <- mean(z_iq^3)
gamma_1


## Calcoliamo i quartili
Q <- quantile(iq, probs=c(0.25, 0.5, 0.75))
Q

## Guardiamo i quarili sull'istogramma
hist(iq)
abline(v = Q, col = 2)



## Calcoliamo le distanze di Q1 e Q3 dalla mediana=Q2
Q[2] - Q[1]
Q[3] - Q[2]
## ... incredibile!


## Calcoliamo il coefficiente di Yule-Bowley
B1 <- { Q[1] + Q[3] - 2*Q[2] } / {Q[3] - Q[1]}
B1


