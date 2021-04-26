## =============================================================================
## Corso:          Statistica computazionale 
## Cdl/Percorso:   Management e Informatica
## Docente:        Pietro Coretto (pcoretto@unisa.it)
##
## Argomenti:
##  + dati multivariati
##  + scatterplot multivariati ed altre rappresentazioni
##  + misure di centralità e dispersione in dimensione p ≥ 2
##  + matrici di covarianza e correlazione
##  + dipendenza, associazione e connessione
##  + rappresentazioni grafiche di table
## =============================================================================




## Importiamo il data set
## http://www.decg.it/pcoretto/datasets/card_README.txt
##
load(url("http://www.decg.it/pcoretto/datasets/card.RData"))
str(card_dataset)


## Lavoriamo con un dataset più piccolo che contiene sono una parte delle variabili
V <- c("iq", "age" , "educ" , 
       "fatheduc",  "motheduc", 
       "black", "south" , 
       "wage", "exper")   
X <- card_dataset[ , V]



## Scatter-plot a coppie
## Wage è espresso in (centesimi di dollari USA)/ora  riferiti al 1976
plot(X$educ, X$wage , pch = 20, col = "#666699", cex = 2,
     xlab = "Numero di anni scolastici frequentati",
     ylab = "Salario orario in $/100 (1976)")



## Riscaliamo wage in dollari/ora riferiti  al 2020
## 1$ del 1976 = $4.64 del 2020 (vedi: https://www.inflationtool.com)
W <- {X$wage / 100} * 4.64
plot(X$educ, W , pch = 20, col = "#666699", cex = 2,
     xlab = "Numero di anni scolastici frequentati",
     ylab = "Salario orario in $ (2020)")







## Condiziamento usando colori e simboli
## *************************************

## Creamo un vettore che contiene il colore da assegnare ad ogni 
## unità del campione. Vogliamo colorare i punti in 
##   nero  se black = 1,  
##   rosso se black = 0 
u_col <- ifelse(X$black == 1 , "black", "red")
plot(X$educ, W  , pch = 20,  col = u_col, cex = 2,
     xlab = "Numero di anni scolastici frequentati",
     ylab = "Salario orario in $ (2020)")



## Possiamo condizinare anche usando un point symbol (pch)  diverso
##   + se black = 1,  
##   * rosso se black = 0 
u_pch = ifelse(X$black == 1 , "+", "*")
plot(X$educ, W , pch = u_pch,  col = u_col, cex = 2,
     xlab = "Numero di anni scolastici frequentati",
     ylab = "Salario orario in $ (2020)")

## aggiungiamo anche delle linee verticali che distinguono  i vari
## periodi scolastici
abline(v=c(5,8,13,16), lty = 2, col = "gray25")
abline(h = mean(X$wage), lwd = 2, col = 4)



## Pairs-plot
## Prendiamo solo le prime 5 variabili e guardiamo gli scatter a coppie
pairs(X[, 1:5] , pch = 20 , col = "#666699")




## Covarianza e correlazione
## *************************
cov(X$iq, X$fatheduc)

cov(X$iq, X$fatheduc , use = "pairwise.complete.obs")

cor(X$iq, X$fatheduc , use = "pairwise.complete.obs")

cor(X$iq, X$motheduc , use = "pairwise.complete.obs")

## matrice di covarianza/correlazione
R <- cor(X, use = "pairwise.complete.obs")
R

S <- cov(X, use = "pairwise.complete.obs")
S

## varianza generalizzata
det(S)



## Heatmap di una matrice di correlazione
## **************************************
## Installiamo il package "vcd" da console
## install.packages("pheatmap")

## Nota: possiamo anche installare da RStudio andando in 
## Tools > Install packages

## carichiamo la libreria "vcd"
library(pheatmap)

## Visualizziamo la Heatmap associata alla matrice di correlazione
pheatmap(R)








## Tabelle a doppia entrata e Chi^2
## ********************************

## Tabella a doppia entrata con frequenze assolute
tabA <- table(IQ      = cut(X$iq, breaks = c(50,100,150)),
              Educ =    cut(X$educ, breaks = c(5,8,13,16))
              )
tabA

## Passiamo alle frequenze relative
tabB <- tabA / sum(tabA)
tabB

round(tabB, digits = 3)

## Aggiungiamo le mariginali  
addmargins(tabB)





## Indice Chi^2
summary(tabA)

## nota
names(summary(tabA))

## quindi possiamo estrarre l'indice chi^2
chi2 <- chisq.test(tabA)$statistic
chi2


## Indice di Cramer = chi^2 normalizzato 
## Indice di Cramer = 0 in caso di assenza di associazione/dipendenza
## Indice di Cramer = 1 in caso di fortissimo legame di associazione/dipendenza
n      <- sum(tabA)
h      <- nrow(tabA)
k      <- ncol(tabA)
chimax <- n * min ( c(h-1, k-1) ) 
Phi2 <- chi2 / chimax
Phi2






## Mosaic plot
## ***********

## Installiamo il package "vcd" da console
install.packages("vcd")

## Nota: possiamo anche installare da RStudio andando in 
## Tools > Install packages

## carichiamo la libreria "vcd"
library(vcd)


## I seguenti comandi creano due vettori di 100 osservazioni indipendenti
## questi comandi saranno chiari nella lezione successiva 
set.seed(1)
v1 <- sample(c("A",  "B" , "C", "D"), size = 100, replace = TRUE)
v2 <- sample(c("Bello",  "Brutto"),   size = 100, replace = TRUE)


## Costruiamo la distribuzione di frequenze assolute
tab_doppia  <- table(v1, v2)
tab_doppia



 
## Interpretazione del mosaic plot
## *******************************
##
##  + l'area i ogni rettangolo è proporzionale alla frequenza osservata per ogni 
##    coppia di livelli dei  fattori in riga/colonna della tabella di frequenze 
##  + se i due fattori fossero piuttosto indipendenti i "gaps" tra i rettangoli
##    del mosaico risulterebbero abbastanza allineati (sia in  orizzontale,
##    che in  verticale)
##  + se i due fattori fossero fortemente associati  i "gaps" risulterebbero 
##    fortemente disallineati 
##  + ogni rettangolo ha un colore che identifica il valore del 
##    "residuo di Person", la cui scala dei colori è indicata a destra
##  + un residuo di Person  prossimo a zero indica che la frequenza osservata 
##    è pari a quella che osserverei in caso di indipendenza
##  + un residuo di Person maggiore di zero in valore assoluto indica 
##    l'esistenza di un legame associativo. Questo sarà tanto più forte
##    quanto più il residuo di Person in valore assoluto devia dallo zero

## Caso di dati indipendenti
mosaic(tab_doppia, shade=TRUE, legend=TRUE)

## Consideriamo nuovamente la tabella precedente
mosaic(tabA, shade=TRUE, legend=TRUE)



















##
