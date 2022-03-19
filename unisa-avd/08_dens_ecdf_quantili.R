## =============================================================================
## Corso          Analisi e Visualizzazione dei Dati [0212800004] / Parte I
## Cdl/Percorso   Statistica per i Big Data (L41)
## Docente        Pietro Coretto (pcoretto@unisa.it)
##
##
##  Argomenti:
##   * densità e istogramma
##   * frequenze cumulate
##   * ecdf
##   * quantili empirici
##   * ordinamenti (semplici e gerarchici)
##   * quantili basati sullo smoothing dei dati ordinati
##
## Ultimo aggiornamento: 20-02-2022 at 10:49:23 (CET)
## =============================================================================



## Premessa: funzione diff()
y <- c(0, 1, 3, 10)
diff(y)




## Densità ed istogramma
## *********************

## Consideriamo i dati osservati
x <- c(-5, 1, 0, 1, 4, 5, 7, 1, 3, 2, 3, 7)

## n = sample size = dimensione campionaria
n <- length(x)

## Costruiamo l'istogramma con le seguenti classi
## [-5, 0]
## (0,  3]
## (3,  7]
h <- hist(x, breaks=c(-5, 0, 3, 7))

## Il comando produce un oggetto di classe "histogram"
h

## h$breaks = estremi degli intervalli di classe
h$breaks

## h$counts = frequenze assolute = n_k
n_k <- h$counts
n_k

## Da cui otteniamo le frequenze relative di classe = f_k
f_k <- n_k  / n
f_k

## Delta_k = Ampiezza dei tre intervalli
Delta_k <- diff( h$breaks )
Delta_k


## Da cui otteniemo dens_k = densità dei punti nella k-ma classe di livelli
dens_k = f_k / Delta_k
dens_k


## infatti!
h$density





## Istogramma con classi uniformi (equiampie)
## ******************************************
##
## Se non diamo il parametro "breaks", il default di R è il windowing basato
## sul K ottimale di Sturges
K_Sturges <- 1 + ceiling( log2(n) )
K_Sturges


## Note:
##  * R applica una piccola correzione per evitare che K sia troppo grande/piccolo
##    per n troppo grande/piccolo, in questo caso infatti determina K=7
##
##  * la regola di Sturges produce K classi uniformi (equiampie), quindi ha
##    senso scalare l'asse verticale dell'istogramma in termini di frequenze
##    assolute
hSturges <- hist(x)
hSturges





## Istogramma con K (prefissato) classi equiampie
## # ********************************************

## Fissiamo K
K <- 4

## Calcoliamo  i breaks (estremi di classe)
b <- seq( min(x),  max(x),  length = K+1)
b

## Nota: l'asse verticale è scalato automaticamente in termini di frequenze
## assolute (counts)
h4 <- hist(x, breaks = b )
h4

## quando l'argomento 'breaks' è un intero, specifica il numero K di classi
## equiampie
h42 <- hist(x, breaks = K)
h42

## NOTA: a volte il valore K passato a 'breaks' viene aggiustato da hist()
## in modo da evitare alcuni effetti indesiderati 
h5 <- hist(x, breaks = 5)
h5





## Applicazione al data set bw.csv
## https://pietro-coretto.github.io/datasets/bw/readme.txt
X <- read.csv(file = url("https://pietro-coretto.github.io/datasets/bw/bw.csv"),
              header = TRUE)



## Istogramma di faminc
hist(X$faminc , col=2 ,
     main = "Istogramma del Reddito",
     xlab = "Reddito [migliaia di USD]")



## Istogramma di lfaminc
hist(X$lfaminc , col=4 ,
     main = "Istogramma del log(Reddito)",
     xlab = "log(Reddito) [log(migliaia USD)]",
     density = 3, angle = 60)











## Frequenze cumulate
## ******************

## consideriamo i dati
x <- c(-1,2,0,3,2,1,1,0,5,6,6,7)
n <- length(x)

## Funzione di conteggio: calcoliamo 1{X <= t} per t=4
ifelse(x <= 4 , 1 , 0)

## Calcoliamo il numero di osservazioni <=t, per t=4
sum ( ifelse(x<=4, 1, 0) )


## Premessa: funzione cumsum (somme cumulate)
u <- c(1,0,2)
cumsum(u)


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









## Applicazione: calcoliamo le ferquenze su faminc con le seguenti K=3
## classi di livelli arbitrarie:
##    [0,  15]
##    (15, 20]
##    (20, 70)


## Prtima di tutto facciamo il windowing di famic nelle tre classi
y  <- cut(X$faminc , breaks = c(0, 15, 20, 70))
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
















## Funzione di distribuzione empirica cumulata (ECDF)
## *************************************************

## Consideriamo i dati
x <- c(-1,2,0,3,2,1,1,0,5,6,6,7)
n <- length(x)


## L'ECDF è ottenuta con ecdf(), essa implementa un metodo che costruisce la ECDF
## del campione osservato
ecdf_x  <- ecdf(x)
ecdf_x

## Per calcolare la IF(x)
ecdf_x(x)

## ecdf() assegna una classe dedicata
class(ecdf_x)

## Infatti ad essa è associato un potente metodo di plot
plot(ecdf_x, main = "La mia prima ECDF")





## Applicazione a faminc
##
par(mfrow = c(2,1))
hist(X$faminc,
     main = "Istrogramma del Reddito"  ,
     xlab = "Reddito [migliaia di USD]"
     )
plot(ecdf(X$faminc),
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

## Consideriamo i dati
x <- c(-1,2,0,3,2,1,1,0,5,6,6,7)
n <- length(x)



## Approssimazione 1: quantili empirici
## ************************************

## Quantile empirico al livello alpha = 0.1
quantile(x , probs = 0.1 , type = 1)

## Nota: supponiamo che vi sia un NA
x[1] <- NA
x
quantile(x , probs=0.1 , type = 1)

## ma...
quantile(x, prob = 0.1,  type = 1 , na.rm = TRUE)


## Calcoliamo i quantile per alpha = 0.1, 0.5, 0.7 con un solo comando
a <- c(0.1, 0.5, 0.7)
quantile(x, prob = a,  type = 1 , na.rm = TRUE)









## Ordinamento dei dati
## ********************
##    * sort()
##    * order()
##    * rank()



## Dati
x <- c(30, 0, 20, 20)
y <- c("0CCC" , "AAA" , "ABB" , "AAB" ,  "1AB" , "AC" , "AAC" , "ABC" ,"1C", "AA")




## Funzione sort(x)
## ****************
##  * ordina x in senso crescente/descrescente ed eventualmente restituisce
##    le posizioni dei valori nel vettore ordinato
##  * se si tratta di stringhe alfanumeriche la precedenza va ai numeri

## Ordinamento non-decrescente (default)
sort(x)

sort(y)



## Esempio: quale valore di x andrebbe al secondo posto del vettore
## ordinato?
a <- sort(x)
a

a[2]


## Ordinamento decrescente
sort(x , decreasing = TRUE)


## Se usiamo il parametro "index.return = TRUE", sort() restituisce una
## lista dove
##   * $x   =  vettore ordinato
##   * $ix  =  sequenza di indici necessari per ottenre il vettore ordinato
sx <- sort(x, index.return = TRUE)
sx

## Infatti sistemando i valori di x  riorganizzati secondo  sx$ix ottengo il
## vettore ordinato
x[ sx$ix ]









## Funzione order(x)
## *****************
##
## * restituisce la sequenza di indici necessari per ottenre il vettore
##   ordinato
##
## * equivale a $ix quando eseguiamo  sort(x, index.return = TRUE)

order(x)

## nota
sx$ix

## Domanda: quale elemento di x devo mettere al terzo posto nel vettor
## ordinato?
ox <- order(x)
x[ox]


## Infatti analogamente a quanto visto prima posso anche ordinare il vettore
## usando order()
x[order(x)]


## Stessa cosa quando volgliamo lavorare con l'ordinamento decrescente
order(x, decreasing = TRUE)

## Infatti
x[ order(x, decreasing = TRUE) ]






## Ordinamento gerarchici
## **********************
##
## Bene, ma allora order(x) equivale a prendere sx$ix? Perché dovrebbero esistere
## due funzioni per fare la stessa cosa? In realtà order() ci permette di effettuare
## ordinamenti secondo una gerarchia di criteri (ordinamento lessicografico)


## Costruiamo un data set, immaginiamo di campionare 5 imprese. Su di esse misuriamo
## 3 features

## Tipo di impresa
ty  <-  c("AB" ,  "AZ" ,  "AB" ,  "AB" , "AZ")
ty

## Regione di appartenenza
reg <- factor(c("Sud" ,  "Centro" ,  "Nord" ,  "Centro" ,  "Centro"),
              ordered = TRUE,
              levels = c("Nord", "Centro", "Sud")
              )
reg

## Numero di dipendenti
nd  <- c(12 , 100 , 12,  200,  10)
nd

## Assembliamo il data set
A <- data.frame(tipo = ty , regione = reg , numdip = nd)
A




## Esempio 1 (ordinamento semplice)
## ordiniamo le righe del data set in base al  numero di dipendenti
idx1 <- order(A$numdip)
A[idx1 , ]



## Esempio 2 (ordinamento semplice)
## ordiniamo le righe del data set in base alla regione
idx2 <- order(A$regione)
A[idx2 , ]



## Esempio 3 (ordinamento gerarchico)
## ordiniamo le righe del data set usando il seguente criterio "lessicografico"
##    * prima considero il tipo
##    * a partità di tipo  considero la regione
##
idx3 <- order( A$tipo,  A$regione)
A[idx3 , ]



## Esempio 4 (ordinamento gerarchico)
## ordiniamo le righe del data set usando il seguente criterio "lessicografico"
##    * prima considero il numero di dipendenti
##    * a partità di dipendenti   considero la il tipo
##    * a partià dei criteri precedenti considero la regione
##
idx4 <- order(A$numdip,  A$tipo, A$regione)
A[idx4 , ]








## Funzione: rank()
## ****************
##  * restituisce il rank = posizione di ogni osservazione nella lista ordinata
##  * in pratica calcola  il "(j)"  che abbiamo definito nell  slides
##  * attenzione: ci sono diversi modi per gestire la presenza di ties,
##    per ottenere i rank introdotti a lezione usiamo  ties.method = "first"

## Ritorniamo a
x

## Il seguente metodo riproduce i rank calcolati come nell'esempio delle slides
rank(x, ties.method = "first")


## Quale è la posizione del valore x[2] nella lista ordinata?
j <- rank(x,   ties.method = "average")
j

j[2]







## Quantili ottenuti mediante smoothing sui dati ordinati
## (approssimazione 2)
## ******************************************************

## Consideriamo i dati
x <- c(-1,2,0,3,2,1,1,0,5,6,6,7)
n <- length(x)

## Fissiamo alpha = 0.1
alpha <- 0.1

## Calcoliamo
jstar     <- 1 +  alpha * {n-1}  ## rank teorico del quantile da calcolare
j         <- floor(jstar)
gamma     <- jstar - j

## Ordino i dati in senso non-decrescente
sx  <- sort(x)

## Possiamo ora calcolare l'approssimazione
X_alpha  = {1-gamma} * +sx[j] + gamma * sx[j+1]
X_alpha



## Questa approssimazione corrisponde esattamente al type=7 della funzione
## quantile(). Questo è il type di default
quantile(x, probs = alpha , type = 7)



## Calcoliamo altri i quantili con il type=7=default per faminc
## ai livelli c(1/4 ,  1/2 , 3/4)
quantile(X$faminc, probs=c(1/4, 1/2, 3/4))










## *****************************************************************************
## APPENDICE:
## ripeti con attenzione la lezione. Explora i seguenti comandi
## ed assicurati di aver compreso pienamente il risultato dell'esecuzione
## *****************************************************************************



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








## Approfondimento sui Ranks
## *************************

## considera i dati dell'esempio
x <- c(30, 0, 20, 20)

## La definizione di rank introdotta a lezione è corrisponde a
rank(x, ties.method = "first")


## Un modo alternativo per gestire i ties è il metoto "average":
##
##   * l'osservazione x=20 compare due volte, il comando precedente
##     assegna due rank distinti: { 2 , 3}
##   * la media dei ranks è (2+3)/2 = 2.5
##
## Il metodo "average" funziona così: se osservo un valore ripetuto assegna
## la media dei ranks che otterrei con ties.method = "first"

rank(x, ties.method = "average")

