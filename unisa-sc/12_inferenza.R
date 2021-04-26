## =============================================================================
## Corso:          Statistica computazionale 
## Cdl/Percorso:   Management e Informatica
## Docente:        Pietro Coretto (pcoretto@unisa.it)
##
## Argomenti:
##  + richiami su intervalli di confidenza e test delle ipotesi
##  + stime per intervallo su parametri di uso comune
##  + tests delle ipotesi di uso comune
## =============================================================================



## Generiamo dati iid
set.seed(1)
n <- 100
x <- rnorm(n , mean = 10 , sd = 3)


## Intervallo per la media di popolazioni normle (t-test)
t.test(x, conf.level = 0.95)


## la funzione restituisce molti valori...
tt <- t.test(x, conf.level = 0.95)
names(tt)


## t-test: H0: mu = m0  H1: mu < mu0
## Nota: Rifiuto H0 se p-value < livello di significatività (5%)
mu0 <- 10
t.test(x, mu = mu0, alternative = "less")


## t-test: H0: mu = m0  H1: mu > mu0
t.test(x, mu = mu0, alternative = "greater")


## t-test: H0: mu = m0  H1: mu diverso da  mu0
t.test(x, mu = mu0, alternative = "two.sided")




## Confronti tra medie per popolazioni normali
## *******************************************


## Consideriamo due campioni normali
set.seed(2)
A <- rnorm(100 , mean = 1 , sd = 3)
B <- rnorm(350 , mean = 2 , sd = 4)



## Confronto tra medie dati per campioni indipendenti
##
## H0: media_x - media_y = delta
## H1: media_x - media_y diverso da delta (alternative = "two.sided")
##     media_x - media_y < delta          (alternative = "less")
##     media_x - media_y > delta          (alternative = "greater")




## Testiamo la nulla con delta = 1/2
## H0 : mu_A - mu_B = 1/2           
## H1 : mu_A - mu_B diverso da 1/2
delta <- 0.5
t.test(x = A, y = B , mu = delta , alternative = "two.sided" ,
       paired = FALSE , var.equal = FALSE)




## Confronto tra medie dati per campioni dipendenti
set.seed(3)
A <- rnorm(100)
B <- A + runif(100)
       
## H0: media_x - media_y = delta
## H1: media_x - media_y diverso da delta (alternative = "two.sided")
##     media_x - media_y < delta          (alternative = "less")
##     media_x - media_y > delta          (alternative = "greater")

delta <- 0
t.test(x = A, y = B, mu = delta , alternative = "less" , paired = TRUE)





## Proporzioni
## ***********

## H0: p = p0
## H1: p diverso da p0  (alternative = "two.sided")
##     p  < p0          (alternative = "less")
##     p  > p0          (alternative = "greater")



## Supponiamo  in campione casuale di n=37 persone 10 abbiano dichiarato di
## votare per il candidato X. Sia p = proporzione dei votanti per il candidato
## X
##
## Vogliamo testare l'ipotesi
##   Ho: p  = 1/3
##   H1: p  < 1/3
prop.test(x = 10, n = 37, p = 1/3,  alternative = "less")





## Confronto tra proporzioni
##
## H0: p_x - p_y = 0
## H1: p_x - p_y diverso da 0 (alternative = "two.sided")
##     p_x - p_y < 0          (alternative = "less")
##     p_x - p_y > 0          (alternative = "greater")

## Supponiamo che nel campione A 400 persone su 500 dichiarano che voterebbero
## il patito X, mentre nel campione B voterebbero il partito X 200 persone su 350
## intervistati.
##
## Vogliamo testare l'ipotesi 
##   H0: p_A - p_B = 0
##   H1: p_a - p_B > 0
prop.test(x = c(400, 200), n = c(500, 350), alternative = "greater")





## Test di indipendenza  (test chi-quadro)
##
## H0: X e Y sono indipendenti
## H1: X e Y sono dipendenti


## Simuliamo due campioni di variabili nominali A e B in modo indipendente
set.seed(4)
n <- 100
A <- sample(c("L", "M", "H"), size = n, replace = TRUE , prob = c(0.4,0.2 ,0.2 ))
B <- sample(c("P", "Q"), size = n, replace = TRUE , prob = c(0.75,0.25))
chisq.test(table(A,B))


## Creiamo una  dipendenza tra totale tra A ed un nuova variabile B1
B1 <- rep("Q", times = n)
B1 <- ifelse( A == "M" , "P", "Q")
table(A, B1)
chisq.test(table(A,B1))





## Confronti tra distribuzioni: strumenti grafici

## Due variabili che hanno una distribuzione simile, produrrano campioni con ECDF
## simili, e quindi anche i quantili empirici saranno simili per un fissato livello
## alpha. Il QQ-plot si basa su questa osservazione elementare.


## Simuliamo dati che a prima vista potrebbero produrre istogrammi di forma simile
set.seed(5)
n <- 250
x <- rnorm(n, mean = 7 ,  sd = sqrt(1.67))
y <- 7 + rt(n , df = 5)



## Visualizziamo i due istogrammi
par(mfrow = c(2,1))
hist(x, breaks = "FD")
hist(y, breaks = "FD")


## Il QQ-plot permette di verificare graficamente quanto sono simili le distribuzioni
## le distribuzioni campionarie di X e Y
qqplot(x, y)
## aggiungiamo la bisettrice y = x
abline(coef = c(0,1), col = 2)


## Il QQ-plot può essere anche utilizzato per verificare l'aderenza della ECDF ad
## modello di probabilità specifico. Ad esempio verifichiamo se la distribuzione
## campionaria di x è simile a quella del modello Normale
qqnorm(x)
qqline(x , col = 2)


## controlliamo la normalità di y
qqnorm(y)
qqline(y , col = 2)




## Test di adattamento di Kolmogorov-Smirnov (un campione)
##
## H0: F = F0
## H1: F diverso da F0
##
## Ad esempio testiamo la normalità, ovvero F0 = Normale(0,1)
ks.test(x , "pnorm", mean = 0, sd = 1)


## Testiamo F0 = Normale(7 , 1.67)
ks.test(x , "pnorm", mean = 7, sd = sqrt(1.67))


## Vogliamo usare il test di Kolmogorov-Smirnov per testare l'adattamento ad
## un modello anche quando non abbiamo nessuna idea di quali possano essere i
## valori dei parametri da sottoporre a test. In pratica li stimiamo dai dati.
##
## ! Attenzione !: adesso sotto la nulla abbiamo
##                 F0 = Normale(media = mean(x), sd = sd(x))
##                 la nulla è sample dependent! Quindi il pvalue del test è
##                 affetto  da una sorgente di casualità aggiuntiva 
ks.test(x , "pnorm")




## Test di adattamento di Kolmogorov-Smirnov a due campioni
##
## Osserviamo due campioni indipendenti X e Y, testiamo 
## H0: F_X = F_Y
## H1: F_X diverso da F_Y
##
## Ad esempio testiamo la normalità, ovvero F0 = Normale(0,1)
ks.test(x , y)







