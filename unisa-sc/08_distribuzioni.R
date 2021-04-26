## =============================================================================
## Corso:          Statistica computazionale 
## Cdl/Percorso:   Management e Informatica
## Docente:        Pietro Coretto (pcoretto@unisa.it)
##
## Argomenti:
##   + raw data e visualizzazione mediante stripchart 
##   + distribuzione di dati univariata (DU) 
##   + distribuzioni di frequenza 
##   + stripchart, barplot, e piechart
##   + densità mediante istogramma 
##   + kernel density 
##   + distribuzione empirica cumulata (ECDF) 
##   + quantili 
##   + boxplot
## =============================================================================



## Importiamo il data set "Birth Weights"
## http://www.decg.it/pcoretto/datasets/bwght_README.txt
## 
X <- read.csv(file = url("http://www.decg.it/pcoretto/datasets/bwght.csv"),
              header = TRUE)

str(X)

## Numero di campioni
n <- nrow(X)

## Per comodità lavoriamo con il dataset in attachment
attach(X)








## windowing dei dati continui
## ***************************

## Funzione cut()! Con essa possiamo trasformare una X
## quantitativa in un "factor" i cui labels sono l'intervallo di appartenenza
y <- c(-10, 3,  10)
cut(y, breaks = 2)

## Numero di classi equiampie 
K <- 5

## Ritorniamo a lfaminc
int <- cut(faminc, K)
str(int)
levels(int)

## Infatti
int


## classe arbitrarie
int2 <- cut(faminc, breaks = c(0, 0.5, 1, 2, 5, 20, 50, 100))



## Frequenze / counts
## ******************
##
## Prima di tutto esploriamo la funzione table()
x <- c(10,10,1,1,3,10,1,1,2)
table(x)

x <- c("A", "A", "C", "B", "C")
table(x)

## Quanti sono i livelli distinti di faminc?
length(unique(faminc))

## Costruiamo una distribuzione di frequenze usando tutti i livelli
## espressi

## Frequenze assolute
table(faminc)

## Frequenze relative
table(faminc) / n

## Frequenze relative percentuali
table(faminc) / n * 100




## Facciamo il windowing prendendo 3 intervalli di livelli uniformi
## Per comodità mettiamo questo dentro un array
CutFaminc <- cut(faminc, breaks = 3)
CutFaminc


## cut() restituisce un fattore... quindi proviamo a passarlo nella funzione
## table()
table( CutFaminc )

## Quindi otteniamo frequenze assolute/relative come prima ....
table( CutFaminc )  / n

## Frequence relative percentuali
table( CutFaminc  )  / n * 100


## Otteniamo una distribuzine di frequenza doppia (percentuale)
## del Reddito-Sesso del bimbo, si noti il bimbo è maschio se male=0
table(Reddito=CutFaminc , Sesso=male )  / n * 100








## Stripchart
## **********
stripchart(faminc)

stripchart(faminc, pch = 21, col = 2, 
           main ="Stripchart di faminc",
           xlab = "Reddito familiare in USD (al 1988)")



## Barplot della variabile X$height
ni_male <- table(male)
barplot(height = ni_male)



## Barplot in termini di frequenze assolute
barplot(height = ni_male,
        names.arg = c("Femmina", "Maschio"),
        col = c(2,4),
        main = "Sesso del primo figlio",
        ylab = "Freq. assolute")


## Barplot in termini di frequenze percentuali
barplot(height = ni_male / n * 100,
        names.arg = c("Femmina", "Maschio"),
        col = c(2,3),
        main = "Sesso del primo figlio",
        ylab = "Frequenza [%]")


## Piechart
## ********
pie(ni_male)


## Controlliamo i diversi parametri
pie(x = ni_male / n * 100,
    labels = c("Femmina", "Maschio"),
    col = c(2,3),
    main = "Sesso del primo figlio")






## Frequenze cumulate
## ******************

## Premessa: funzione cumsum (somme cumulate)
u <- c(1,0,2)
cumsum(u)


## consideriamo i dati
x <- c(-1,2,0,3,2,1,1,0,5,6,6,7)
n <- length(x)

## Frequenze  assolute
n_k <- table(x)
n_k


## Frequenze cumulate assolute
N_k <- cumsum(n_k)
N_k

## Frequenze relative
f_k <- n_k / n
f_k

## Frequenze cumulate relative
F_k <- N_k / n
F_k

## oppure
cumsum(f_k)



## Ccalcoliamo le ferquenze su faminc con le seguenti K=3
## classi di livelli arbitrarie:
##    [0,  15]
##    (15, 20]
##    (20, 70)


## Prtima di tutto facciamo il windowing di famic nelle tre classi
y  <- cut(faminc , breaks = c(0, 15, 20, 70))
ny <- length(y)

## Frequenze assolute
y_nk <- table(y)
y_nk

## Frequenze relative percentuali
y_fk <- table(y) / ny * 100
y_fk

## Frequenze assolute cumulate
cumsum( y_nk )

## Frequenze relative cumulate percentuali
cumsum(y_fk)











## Densità, istogramma, e kernel density
## *************************************

## Consideriamo i dati osservati
x <- c(-5, 1, 0, 1, 4, 5, 7, 1, 3, 2, 3, 7)

## n = sample size = dimensione campionaria
n <- length(x)

## Costruiamo l'istogramma con le seguenti classi
## [-5, 0]
## (0,  3]
## (3,  7]
h <- hist(x, breaks = c(-5, 0, 3, 7))


## Il comando produce un oggetto di classe "histogram"
h

## Ampiezza di banda ottimale di Friedman-Diaconis 
hist(x, breaks="FD")

## Istogramma di faminc con stripchart in basso
hist(faminc , col=2 , breaks="FD", 
     main = "Istogramma del Reddito",
     xlab = "Reddito [migliaia di USD]")
## per produrre lo stripchart
rug(faminc, col=1)



## nota: faminc è stato misurato discretizzando i redditi, la funzione jitter
## sparpaglia i dati leggermente permettendo di vedere i dati ripetuti, es:
jitter(c(1,1,1))


## esempio di jitter sullo stripchart
stripchart( jitter(faminc) )


## tornando al grafico precedente
hist(faminc , col=2 , breaks="FD", 
     main = "Istogramma del Reddito",
     xlab = "Reddito [migliaia di USD]")
rug(jitter(faminc), col=4)


## tornando al grafico precedente guardiamo cosa succede in logaritmi 
hist(log(faminc) , col=2 , breaks="FD", 
     main = "Istogramma del Reddito",
     xlab = "Reddito [migliaia di USD]")
rug(jitter(faminc), col=4)





## Stima di funzione di densità continua mediante Kernel Density (smoothing) 
plot(density(faminc))
rug(jitter(faminc), col=4)


## bandwidth troppo piccola, stima di densità troppo locale
plot(density(faminc , bw=0.5))
rug(jitter(faminc), col=4)


## bandwidth troppo grande, stima di densità troppo globale
plot(density(faminc , bw=20))
rug(jitter(faminc), col=4)








## Funzione di distribuzione empirica cumulata (ECDF)
## *************************************************

## Richiami: sia t un quantità reale, l'ECDF è una funzione dei dati osservati
## definata come segue
##
##        ECDF(t) = proporzione di dati osservati  minori o uguali di t
##



## consideriamo i dati
x <- c(-1,2,0,3,2,1,1,0,5,6,6,7)
n <- length(x)

## costruiamo l'ECDF
ecdf_x  <- ecdf(x)
ecdf_x


## calcoliamo l'ecdf nel punto t=5
ecdf_x(5)


## Infatti ad essa è associato un potente metodo di plot
plot(ecdf_x, main = "La mia prima ECDF")
rug(jitter(faminc), col=4)





## Applicazione a faminc
ecdf_faminc <- ecdf(faminc)

## calcoliamo l'ecdf a t=15 (15000$), cosa noti?
ecdf_faminc(15)

## calcoliamo l'ecdf a t=27 (27000$), cosa noti?
ecdf_faminc(27)

## calcoliamo l'ecdf a t=40 (40000$), cosa noti?
ecdf_faminc(40)




## Grafico combinato
par(mfrow = c(2,1))
hist(faminc,
     main = "Istrogramma del Reddito"  ,
     xlab = "Reddito [migliaia di USD]"
)
plot(ecdf(faminc),
     main = "ECDF del Reddito" ,
     xlab = "Reddito [migliaia di USD]"
)


## Interpretazioni ed osservazioni:
##
##   * esempio: vediamo subito che circa l'80% delle famiglie ha un reddito
##     <= 50 mila dollari
##
##   * esempio: circa il 40% delle famiglie più povere non guadagna più di
##     20 mila USD
##
##   * nelle regioni dove l'istogramma è più alto (alta densità),
##     la ECDF ha in media una "pendenza" più ripida
##
##   * nelle regioni dove i dati sono meno densi (istogramma più basso)
##     la ECDF cresce meno rapidamente (piatta)











## Approssimazioni numeriche dei quantili
## **************************************


## Approssimazione 1: quantili empirici 
## ************************************

## Quantile empirico al livello alpha = 0.1
quantile(faminc , probs=0.1 , type = 1)

## Nota: supponiamo che vi sia un NA
faminc[1] <- NA
quantile(faminc , probs=0.1 , type = 1)

## ma...
quantile(faminc, prob = 0.1,  type = 1 , na.rm = TRUE)


## Calcoliamo i quantile per alpha = 0.1, 0.5, 0.7 con un solo comando
quantile(faminc, prob = c(0.1, 0.5, 0.7),  type = 1 , na.rm = TRUE)





## Quantili ottenuti mediante smoothing sui dati ordinati
## (approssimazione 2)
## ******************************************************

## Questa approssimazione corrisponde esattamente al type=7 della funzione
## quantile(). Questo è il type di default
quantile(faminc, type = 7 , na.rm = TRUE)

## questo è il default, infatti
quantile(faminc, na.rm = TRUE)


## Calcoliamo i decili
a <- seq(0, 1, by = 0.1)
quantile(faminc, probs = a, na.rm = TRUE)


## Calcoliamo i percentili
b    <- seq(0, 1, by = 0.01)
perc <- quantile(faminc, probs = b, na.rm = TRUE)

## Curva dei percentili
plot( b*100 , perc , t='l' , xlab = "Livello del Percentile [%]" , ylab = "Reddito [1000x$]")









## BOXPLOT
## *******

boxplot(bwghtlbs)


## Parametri grafici generici 
boxplot(bwghtlbs, 
        horizontal = TRUE, 
        xlab = "Peso [lb]",
        col = "#8191d3")



## Boxplot del peso condizionatamente al sesso 
peso_m <- bwghtlbs[male == 1]
peso_f <- bwghtlbs[male != 1]
boxplot(peso_f, peso_f,  
        horizontal = TRUE, 
        xlab = "Peso [lb]",
        col = c("#FCE4EC", "#85C1E9"))



## la stessa cosa si puo' fare senza estrarre i dati per sesso
## Nota: per ottenere ~ su una tastiera "Italian"
##  + Linux/Unix :: ALTGr + ì 
##  + MACOS      :: ALT + 5
##  + Wndows     :: ALT + 126
boxplot(bwghtlbs ~ male,  
        horizontal = TRUE, 
        xlab = "Peso [lb]",
        col = c("#FCE4EC", "#85C1E9"))
















## *****************************************************************************
## ESERCIZI:
## ripeti con attenzione la lezione. Explora i seguenti comandi
## ed assicurati di aver compreso pienamente il risultato dell'esecuzione
## *****************************************************************************


## Diff e range
y<- c(1,2,5,3,4,7)

diff(y)

diff(range(y))




## Prova a modificare  i parametri della funzione cut()
y <- c(0,-1,2,4,2,5)

cut(y, breaks = 3 , include.lowest = TRUE , right = FALSE, dig.lab = 1)

cut(y, breaks = c(1,2,3))





## Consideriamo i dati osservati
x <- c(-5, 1, 0, 1, 4, 5, 7, 1, 3, 2, 3, 7)

## Cosa ottieni con il seguente comando
plot( cut(x, breaks = 4) )







## ECDF
## ****

## Consideriamo i dati
x <- c(-1,2,0,3,2,1,1,0,5,6,6,7)

## Ottieni direttamente l'ECDF
plot( ecdf(x) )

## Prova a cambiare i parametri generici del metodo plot()
plot(  ecdf(x) , xlab="Pippo", col=2, lwd = 2, pch=5, cex =4)


