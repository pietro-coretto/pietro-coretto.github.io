## =============================================================================
## Corso:          Statistica computazionale 
## Cdl/Percorso:   Management e Informatica
## Docente:        Pietro Coretto (pcoretto@unisa.it)
##
## Argomenti:
##   + richiami sulle principali distribuzioni di probabilità
##   + generazione di numeri casuali
##   + funzioni di densità, distribuzione e quantile
##   + rappresentazione grafiche delle distribuz    ioni di probabilità
##   + elementi di simulazione Monte Carlo
## =============================================================================





## Distribuzioni di probabilità:
## *****************************
##
##  + ogni distribuzione è denotata con un acronimo, in generale
##    chiamiamolo DIST
##  + per ogni distribuzione di sono in genere quattro funzioni:
##
##     * rDIST = generazione di numeri casuali, campionamento iid
##     * dDIST = funzione di densità (continue), funzione di massa
##               massa di probabilità (discrete)
##     * pDIST = funzione di distribuzione (ripartizione) cumulata
##     * qDIST = funzione quantile (inversa della funzione di distribuzione)





## Acronimi delle principali distribuzioni
## ***************************************
##
## normale           norm
## uniforme          unif
## Student-t         t
## Chi^2             chisq
## F                 f
## Log-normale       lognormal
## Binomiale         binom
## Poisson           pois
## Esponenziale      exp





## Generazioni di numeri casuali (campionamento iid)
## *************************************************

## Generiamo tre numeri da una normale standard (meadia=0, sd=1)
rnorm(n = 3)


## Fissiamo il "seme iniziale" per la catena di generazioni casuali 
set.seed(12345)
rnorm(n = 3)


## campionamento iid da una normale non standard 
x <- rnorm(n =250 , mean = 100 , sd = 5 )

hist(x , main = "Dati Normali")

plot(ecdf(x))



## campionamento iid da una Student-t con 2 gradi di libertaà
x2 <- rt(n = 250 , df = 2 )

hist(x2 , main = "Dati da una t_2")


## campionamento iid da una uniforme su supporto [0,1]
x3 <- runif(n = 250 , min = 0, max = 1 )

hist(x3 , main = "Dati da Uniforme[0,1]")



## campionamento iid da una Binomiale(n=10, p=0.3)
x4 <- rbinom(n = 250 , size = 10 , prob = 0.3)
hist(x4)

barplot(table(x4)/250)



## Funzione di densità/probabilità
## *******************************

## Densità di una normale standard nel punto x=0
dnorm(0)

## Densità di una normale standard nei punti x=-4, -3, -1, 0 1, 2, 3, 4
x <- c(-4, -3, -1, 0,  1, 2, 3, 4)
dnorm(x)


## Densità di una normale (media = 100, sd=6) nei punti  50, 100, 150
dnorm(c(50, 100, 150) , mean = 100, sd = 6)


## Funzione di probabilità nel punto x=4 per una Poisson di parametro lambda = 6
dpois(4, lambda = 6)



## Confrontiamola densità di  una normale standard con quella di una t_3
x <- seq(-6, 6, length = 1000)
dens_norm  <- dnorm(x)
dens_t3    <- dt(x, df = 3)
YLIM       <- range( c(dens_norm, dens_t3) )
plot(x , dens_norm , t = "l" , lwd = 2, col = 1 ,
     ylim = YLIM,
     xlab = "x",
     ylab = "densita(x)")
lines(x , dens_t3 , t = "l" , lwd = 2, col = 2)
legend("topleft",
       legend = c("Normale Standard", "t_3"),
       col = c(1,2),
       lwd = c(2,2))






## Funzione di distribuzione (ripartizione) cumulata  
## *************************************************

## Funzione di distribuzione di una normale standard nel punto x=0
pnorm(0)


## Funzione di distribuzione di una normale standard nei punti
x <- c(-1.675, 1.675)
pnorm(x)

## Funzione di distribuzione di una t_3 negli stessi punti 
pt(x , df = 3)


## Funzione di distribuzione di una normale(10,25) standard nei punti
x <- c(0, 10, 20)
pnorm(x , mean = 10, sd = 5)


## Quale è la Pr{ -1 < Z <= 3}, dove Z ~ N(0,1)? 
## Pr{ -1 < Z <= 3} = Phi(3) - Phi(-1), dove Phi è la funzione di distribuzione
## di Z
pnorm(3)-pnorm(-1)




## Funzione quantile 
## *************************************************

## Quantile normale standard al livello alpha = 5%
qnorm(0.05)
qnorm(0.95)

## Funzione di distribuzione di una normale standard nei punti
## alpha = 1% 2 99%
alpha <- c(0.01, 0.99)
qnorm(alpha)

## quantil della  t_3 allo stesso livello 
qt(alpha , df = 3)



## Confrontiamo i quantili di una normale standard con quelli di una t_3
alpha <- seq(0.01, 0.99, length = 1000)
quant_norm <- qnorm(alpha)
quant_t3   <- qt(alpha, df = 3)
YLIM       <- range( c(quant_norm, quant_t3) )
plot(alpha , quant_norm , t = "l" , lwd = 2, col = 1 ,
     ylim = YLIM,
     xlab = "alpha",
     ylab = "Quantile(alpha)")
lines(alpha , quant_t3 , t = "l" , lwd = 2, col = 2)
legend("topleft",
       legend = c("Normale Standard", "t_3"),
       col = c(1,2),
       lwd = c(2,2))
abline(v=0.5, lty = 3)
abline(h=0, lty = 3)






## Sampling
## ********
##
##  + schemi di tipo urna
##  + campionamento con e senza rimessa
##  + campionamento a probabilità uniformi e non uniformi


## Vettore di "oggetti" da campionare
u  <- c("X", "Y" , "Z")


## Estrazione di 2 oggetti, senza rimessa, a probabilità uniformi  
sample(u, size = 2)

## ripetiamo più volte
sample(u, size = 2)

sample(u, size = 2)

sample(u, size = 2)


## Estrazione di 10 oggetti, con rimessa, a probabilità uniformi  
sample(u, size = 10 , replace = TRUE)


##... ripetiamo l'esperimento
sample(u, size = 10 , replace = TRUE)




## Estrazione di 2 oggetti, senza rimessa, a probabilità non uniformi
## Fissiamo le seguenti probabilità
##    P(X) = 0.7 
##    P(Y) = 0.2
##    P(Z) = 0.1

prXYZ <- c(0.7 , 0.2  , 0.1)
sample(u , size = 2, replace = FALSE , prob = prXYZ)

## ... ripetiamo diverse volte
sample(u , size = 2, replace = FALSE , prob = prXYZ)
sample(u , size = 2, replace = FALSE , prob = prXYZ)
sample(u , size = 2, replace = FALSE , prob = prXYZ)
sample(u , size = 2, replace = FALSE , prob = prXYZ)
sample(u , size = 2, replace = FALSE , prob = prXYZ)


## Estrazione di 100 oggetti, con rimessa, a probabilità non uniformi
dat <- sample(u , size = 100, replace = TRUE , prob = prXYZ)


## ... quali sono le frequenze osservate?
table(dat) / length(dat)




## Simulazione Monte Carlo
## **********************

## Approssimazione del valore atteso (integrale)  di una normale standard
## Ovvero Z ~ Normale(0,1), vogliamo approssimare numericamente E[X]
##
## Simuliamo un campione iid Normale(0,1)
set.seed(1111)
n  <- 10^6
x  <- rnorm( n )

## Usiamo la media campionaria per approssimare E[X], infatti la legge dei
## grandi numeri ci assicura che:  Media_Campionaria --> E[X]
mx <- mean(x)
mx

## Con quale precisione ho approssimato l'integrale precedente?
## Basta calcolare la deviazione standard della media campionaria 
stde <- sd(x) / sqrt(n)


## Quindi un intervallo di confidenza al 95% (alpha = 5%) per l'approssimazione
## è dato da
qz <- qnorm(0.975)  ## quantile al livello 1 - alpha/2
c(mx - qz * stde ,  mx + qz * stde)





## Sia X ~ chisq(df = 5), consideriamo la trasformazione 
##                     U = log(sqrt(X+1))  
## Vogliamo approssimare E[U] =  E[ log(sqrt(X+1)) ]
## 
## Algoritmo Monte Carlo:
##  + produciamo un campione artificiale da una chisq(df = 5), sia esso
##    {x_1, x_2, ..., x_n}
##  + calcoliamo u_i = log( sqrt(x_i + 1) )
##  + calcoliamo la media campionaria su {u_1, u_2, ..., u_n}
##  
## La legge dei grandi numeri ci assicura che
##         Media_Campionaria(u_1, u_2, ..., u_n)  -->  E[ log(sqrt(X+1)) ]
set.seed(1111)
n  <- 10^6
x  <- rchisq( n , df = 5)
u  <- log(sqrt(x+1))

mu     <- mean(u)
stdeu  <- sd(u) / sqrt(n)

## Intervallo al 95% per l'approssimazione
c(mu - qz * stdeu ,  mu + qz * stdeu)






## Esempio: approssimazione di un probabilità 
## ------------------------------------------

## Prob{poker d'assi servito} = 0.0001390434
set.seed(236770)
m      <- 1e+6
mazzo  <- c(rep("ASSO", 4), rep("ALTRO", 48))

X <- rep(0, m)   
for (i in 1:m) {    
    mano <- sample(mazzo, size = 5, replace = FALSE)
    X[i] <- {sum( mano == "ASSO" ) == 4}
}

hat_p <- mean(X)
hat_p

## errore di approssimazione (vero)
abs(hat_p - p)


## MCSE di hat_p
mcse <- hat_p*{hat_p} / sqrt(m)

sd(X)/sqrt(m)





