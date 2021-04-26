## =============================================================================
## Corso:          Statistica computazionale 
## Cdl/Percorso:   Management e Informatica
## Docente:        Pietro Coretto (pcoretto@unisa.it)
##
## Argomenti:
##    * operazioni elementari
##    * funzioni matematiche di base
##    * tipi numerici e tipi speciali
## =============================================================================

## Operazioni elementari
5 + 2

5 * 2

5 - 2

5/2

2^2

2^{ 1/3 }

2 / 0

Inf/3

0 * Inf

Inf - Inf




## Semplici funzioni matematiche
## *****************************

sqrt(4)

exp(2)

log(exp(4))

sin(pi)

cos(pi)

round(5/2, digits = 3)






## Memoria ed assegnazione di variabili locali
## *******************************************

a <-  5

5 -> a

5 <- a  ## !! Attenzione

b <- 2

a + b

a * b

a / b

u <- a+b
u

a <- 10

u <- a+b
u


## ATTENZIONE: evitare l'uso di "T, F, c" per assegnare variabili


## Contenuto del workspace
ls()










## Tipi di dati
## ************

## Floating point
2/3

## Interi
1L

## Alfanumerico
x <- "XYZ"
x

## Logico
x <- TRUE
y <- FALSE
x
y


##  Tipi speciali: NA, NaN and  NULL
x <- NULL
y <- NA
z <- NaN

x
y
z





##  Operatori logici
##  ****************

A <- FALSE

B <- TRUE

! A

A == B

A != B

A & B

A | B

A + B

A * B





## Test sul tipo numerico e coercizione
x <- c(TRUE, FALSE, TRUE)

typeof(x)

is.logical(x)

is.numeric(x)

is.double(x)

is.integer(x)

as.numeric(x)

as.character(x)

as.integer(x)

as.double(x)


