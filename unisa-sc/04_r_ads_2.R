## =============================================================================
## Corso:          Statistica computazionale 
## Cdl/Percorso:   Management e Informatica
## Docente:        Pietro Coretto (pcoretto@unisa.it)
##
## Argomenti:
##    + matrici e principali operazioni dell’algebra lineare
##    + data frame
##    + liste
##    + formattazione dei principali
## =============================================================================




## Matrici (2D arrays)
## *****************************************************************************
##    * sono un tipo speciale di array 2D con atributi che consentono di passare
##      una matrice sotto operazioni definite nell'algebra lineare
##      (det, inversa, prodotto riga-colonna, transposta, etc.)
##    * richiedono due indici per accedere ad un dato (come per i 2D arrays)


x   <- matrix(c(1,2,3,4),  nrow=2,  ncol=2)
x

y   <- matrix(c(1,2,3,4), nrow=2)
y

x1   <-c(1,2,3)
x2   <-c(10,20,30)
x3   <-c(100,200,300)

data    <-c(x1,x2,x3)

X    <- matrix(data, nrow=3, byrow=TRUE)
X

Y    <- matrix(data, nrow=3, byrow=FALSE)
Y

Z    <- cbind(x1, x2, x3)
Z

Z    <- rbind(x1, x2, x3)
Z



## Subsetting di matrici
X[1,1]

X[ ,1]

X[1, ]

X[ , 1 , drop = FALSE]

X[1, , drop = FALSE]

X[-1,]

X[-1,-1]

X[,-2:-3]

X[,-2:-3, drop = FALSE]



## NOTA: spesso le tecniche di subsetting sono utili per trasformare una ADS,
## oppure per modificarne parte del contenuto
X
X[1, ]

X[1, ] <- NA
X

X[1:2, 1:3] <- 1000
X

X  <- X[ , -c(1,3)]






## Operazioni component-wise
## ATTENZIONE: tali operazioni non sono necessariamente definite nell'algebra lineare
X    <- matrix(data, nrow=3, byrow=TRUE)

X * X

X / X

X - 2*X

X^2

sqrt(X)




## Algebra lineare
X  <- matrix(1:6,   nrow=2,  ncol=3)
Y  <- matrix(1:12,  nrow=3,  ncol=4)
Z  <- matrix(1:9,   nrow=3)


## Prodotto riga-colonna
X %*% Y

Y %*% X


## Trasposizione
t(X)


## Determinante
det(X)

det(Z)


## Inversa
solve(Z)


## Diagonale
diag(Z)

diag(1, 10)

diag(Z) <- 100



## Dimensione della matrice
dim(X)

nrow(X)

ncol(X)




## Metadati di matrici
colnames(X)  <- c("A", "B", "C")
rownames(X)  <- c("a", "b")
X

names(X)
colnames(X)
rownames(X)











## LISTE
## *******************************************************************
##    * l'ADS più flessibile in assoluto
##    * ogni elemento può essere un ADS a sua volta
##    * ogni elemento può contenere tipi diversi
##    * utili per strutturare oggetti rappresentati da dati molto complessi

mylist <- list(studente = "Pinco Palla",
               score    = c(18,30,18))

mylist

names(mylist)

mylist$studente

mylist[[1]]

mylist$score

mylist[[2]]

mylist[[2]][-1]

mylist$score[-1]


X <- array(1:12, dim = c(2,6))
mylist$Matrice <- X

mylist

Y <- array(1:27, dim = c(3,3,3))
mylist[[4]] <- Y
mylist


mylist$Matrice <- Y
mylist




## Metadati di liste
names(mylist)

names(mylist) <- c("Nome1", "Nome2", "Nome3", "Nome4")

mylist

mylist$score

mylist$Nome2









## Pulizia del workspace
ls()

rm(list = ls())

ls()






## Data-frames
## *****************************************************************************
##    * uno dei motivi per cui R è diventato popolare
##    * è essenzialmente lista che emula una tabella (2D array)
##    * la restrizione di tipo è che ogni colonna deve essere di tipo omogeneo
##    * ha un ricco corredo di metadati (attributi)
##    * l'ADS ideal per costruire il tipico data set statistico

mydata      <- data.frame(Name = c("Maria", "Giuseppe", "Anna"),
                          Gender = factor(c("F", "M", "F")),
                          Age= c(25,23,21))

mydata

ls()

names(mydata)

mydata$Name

mydata[[1]]

mydata[1]

mydata[,1]

mydata[1,1]

mydata[1, ]

is.data.frame(mydata)

is.list(mydata)




## Link virtuale ai registri di  memoria rispetto alle colonne di un data.frame
attach(mydata)

ls()

Name

Gender

2 * Age

detach(mydata)

Name

dim(mydata)

ncol(mydata)

nrow(mydata)


## Metadati di un data.frame
names(mydata)

colnames(mydata)

rownames(mydata)














