## =============================================================================
## Corso         ::  Analisi e Visualizzazione dei Dati [0212800004] / Parte I
## Cdl/Percorso  ::  Statistica per i Big Data (L41)
## Docente       ::  Pietro Coretto (pcoretto@unisa.it)
##
##
##  Argomenti:
##   * boxplot
##   * banda ottimale nell'istogramma
##   * kernel density
## =============================================================================





## Data set
## https://pietro-coretto.github.io/datasets/card/readme.txt
## 
load(url("https://pietro-coretto.github.io/datasets/card/card.RData"))


## Consideriamo la variabile $wage
x <- card_dataset$wage
y <- log(x)
n <- length(x)
n

## Istrogramma con la banda ottimale di Freedman-Diaconis
hist(x, breaks = "FD")
rug(x)


## Boxplot (default)
boxplot(x)


## Orientamento orizzontale
boxplot(x, horizontal = TRUE)



## La funzione boxplot permette di personalizzare moltissimi aspetti... divertitevi!
## In realtà il suo parametro più importante è "range"
##
##  * range=0.....i baffi del plot si estendono fino agli estremi del range dei
##                dati
##  * range=1.5...i baffi si estendo al massimo fino ai Tukey fences calcolati con
##                k=1.5. Questo è il default.
## Range può essere  posto a qualsiasi valore, questo sposta il valore di K nei
## Tukey fences.

boxplot(x, range = 0, horizontal = TRUE)

boxplot(x, range = 1.5, horizontal = TRUE)

boxplot(x, range = 3, horizontal = TRUE)



## Boxplot ed outliers
## *******************
##
## Ma ha senso fare il flagging degli outliers/gross outliers per una distribuzione
## con asimmetrie così forti? Proviamo a lavorare sui logwage?
hist(y, breaks = "FD", xlab="log(reddito)")
rug(y)

## Qui vediamo gli outliers con k=1.5 (default)
boxplot(y, xlab = "log(reddito)", horizontal = TRUE)

## Qui controlliamo se ci sono i gross outliers con k=3 (default)
boxplot(y, range=3, xlab = "log(reddito)", horizontal = TRUE)


## Qualche volta serve colorare i boxplot
boxplot(y, col=2, xlab = "log(reddito)", horizontal = TRUE)





## Boxplot paralleli
## *****************
## Prendiamo un dataset più piccolo
A <- data.frame(Figli    = card_dataset$educ,
                Padre    = card_dataset$fatheduc,
                Madre    = card_dataset$motheduc)

boxplot(A,
        main = "Livello di Educazione Scolastica",
        ylab = "Anni fino all'ultimo titolo di studio conseguito",
        horizontal = TRUE)




## Distrbuzioni condizionate mediante boxplot
data("PlantGrowth")
head(PlantGrowth)




## Vediamo i boxplot della distribuzione del peso condizionatamente al gruppo
## sperimentale
##
boxplot(PlantGrowth$weight ~ PlantGrowth$group,
        xlab = "Weight [oncia]",
        ylab = "Gruppo Sperimentale",
        col  =  c("#CC0000", "#C88A00", "#99C370"),
        horizontal = TRUE
        )



## --> Slides






## Kernel density
## **************

## Iniziamo a vedere un primo esempio di classe = "density"
d <- density(y)

d

str(d)

## Grafico della densità kernel
plot(d, main = "Distribuzione del log(reddito)")




## Il default di R
## ***************
##  * funzione kernel  = Gaussiana
##  * bandwidth        = "nrd0", cosiddetta rule-of-thumb basata sull'ipotesi
##                       che i dati sono abbastanza "normali"
##
d1 <- density(y, bw = "nrd0", kernel = "gaussian")
plot(d1, main = "Distribuzione del log(reddito)")


## Ora proviamo a tenere fissa la banda e cambiamo la funzione kernel. Usiamo
## il la funzione kernel di Epanechnikov (questa è quasi sempre la migliore
## scelta).
##
d2 <- density(y, bw = "nrd0", kernel = "epanechnikov")
## Sovrapponiamo i grafici
lines(d2, col=2)



## Ora proviamo a fissare la funzione kernel (Epanechnikov)  cambiamo la banda
## rispetto al default

## bw = Default
d0 <- density(y, bw = "nrd0", kernel = "epanechnikov")

## Oversmoothing: bw = 10 volte il default
## In questo caso la finestra sarà troppo grande e la densità tenderà ad
## omogeneizzare
d1 <- density(y, bw = 10 * d0$bw , kernel = "epanechnikov")

## Undersmoothing: fissiamo bw = 1/10 del default
## In questo caso la finestra sarà troppo piccola  e la densità sarà approssimata
## su intorni troppo locali
d2 <- density(y, bw = 0.1 * d0$bw , kernel = "epanechnikov")

## Sovrapponiamo i grafici
plot(d0, col=1, lwd=2, main = "Distribuzione del log(reddito)")
lines(d1 , col=2, lwd = 2)
lines(d2 , col=3, lwd = 2)

## Possiamo calcolare anche il bandwidth ottimale con funzioni specifiche che
## implementano metodi specifici.


## Ad esempio un metodo pituttosto accurato è stato sviluppato da
## Sheather & Jones (1991) ed è implementato in R base package:
bwSJ  <-  bw.bcv(y)
bwSJ

dSJ   <- density(y, bw = bwSJ, kernel = "epanechnikov")
plot(dSJ)





## end
