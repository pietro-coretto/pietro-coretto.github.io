## =============================================================================
## Corso            Analisi e Visualizzazione dei Dati [0212800004] / Parte I
## Cdl/Percorso     Statistica per i Big Data (L41)
## Docente 	        Pietro Coretto (pcoretto@unisa.it)
##
##  Argomenti:
##    * accesso alla documentazione di R
##    * interazione con il sistema operativo
##    * lettura e scrittura di data set in formato ASCII
##    * formattazione di un data set
##    * lettura e scrittura di RData
##    * manipolazioni di stringhe
##    * input/out alla console
##
## last update:  25-02-2021 at 07:25:00 (CET)  
## =============================================================================







## Accesso alla documentazione
## ***************************

## Accedere alla documentazione di una funzione specifica
?sum
help(sum)

## Ricerche su chiavi di ricerca
help.search("linear regression")

## Ricerca di oggetti
apropos("sum")

## Ricerca di esempi
example(sum)








## Interazione con il sistema operativo
## ************************************

## I paths sono sempre passati ad R in formato "character". R nasce in ambiente
## linux/unix e quindi eredita una serie di convenzioni come il separatore "/"
##
## In linux/unix/macos/OS X
##    * "/dirA/dirB/dirC"
##    * "~/dirA/dirB/dirC"
##    * "~/dirA/dirB/filename.ext"
##
## In MS Windows
##    * "C:/dirA/dirB/dirC"
##    * "C:/dirA/dirB/filename.ext"


## Controlla l'attuale directory di lavoro ed il suo contenuto
getwd()
dir()


## Crea una directory nel drive principale del computer
dir.create("C:/tmpAVD")

## Crea un file nella directory appena creata
file.create("C:/tmpAVD/foo.txt")

## Andiamo in "C:\" verifichiamo l'esistenza della directory appena creata

## Fissa la directory precendente come base-path di lavoro
setwd("C:/tmpAVD")

## Controlla la directory di lavoro
getwd()
dir()











## Lettura di un data set: situazioni tipiche
## ******************************************
##
## * Tipicamente un data set si presenta come una sequenza di valori alfa/numerici
##   organizzati in una  tabella (righe x colonne)
##
## * I metodi di storage più comuni sono
##    -CSV: comma-separated-values in un file ASCII. L'esensione più comune
##          è .csv
##    -TSV: tab-separated-values  in un file ASCII. Estensioni tipiche sono
##          .tsv, .dat, .txt
##
## * In alcuni casi i dati sono archiviati in formati binari proprietari la cui
##   lettura/scrittura dipende dal software specifici
##   (es: .mat per Matlab, .RData per R, .xls per MS Excell, etc)




## Lettura di file "comma-separated-values"
## ****************************************
##
##  * Abbiamo un file ASCII con estensione .csv (è possibile qualsiasi estensione)
##  * Le righe sono separate dal carattere di controllo RET
##  * Le colonne sono separate da una virgola (,)
##  * ATTENZIONE: l'abitudine Italiana di separare le migliaia con la virgola
##    puo' essere disastrosa (e.g. 10,000)
##  * ATTENZIONE: la prima riga contiene i dati o i nomi delle variabili/features?

## Lettura del data set "DataSet_X.csv"
X  <- read.table(file="DataSet_X.csv",     sep=","  , header=TRUE)
X

## Attenzione al parametro "header"
XX <- read.table(file="DataSet_X.csv",     sep=","  , header=FALSE)
XX

## Possiamo anche usare read.csv(): essa è una funzione wrapper di
## read.table() con l'opzione  sep=','
X  <- read.csv(file="DataSet_X.csv", header=TRUE)
X

## Struttura
str(X)







## Lettura di un file  tab-separated-values
## *****************************************
##
##  * Abbiamo un file ASCII con estensione .dat (tsv e  txt sono estensioni
##    alternative)
##  * Le righe sono separate dal carattere di controllo RET
##  * Le colonne sono separate dal carattere di controllo TAB (\t)
##  * ATTENZIONE: la prima riga contiene i dati o i nomi delle variabili/features?

Y  <- read.table(file="DataSet_Y.dat",  sep = "\t"  ,  header=TRUE)
Y

## In read.table l'opzione di default è  sep = "\t"
Y  <- read.table(file="DataSet_Y.dat",  header=TRUE)
Y

## Struttura del data set
str(Y)





## Formati binari
## ***************
##
## * Ci sono tantissimi softwares ognuno dei quali con un formato binario, ad esempio
##   .xls:   MS Excell storage format
##   .dta:   STATA storage format
##   .spss:  SPSS storage format
##   .mat:   MATLAB storage format
##    etc
##
## * Ci sono librerie di R che consentono la lettura di molti binari
##
## * I formati binari hanno il vantaggio di poter preservare i metadati come gli
##   attribti di un ADS. Nell'esempio precedente la colonna Date viene letta come
##   un fattore, ma è una data di calendario
##
## * Il formato di di R è  "un "RData"
##   - possono contenere qualsiasi oggetto
##   - preserva i metadati

load(file="DataSet_Z.RData")
Z

## osserva
str(Z)










## Formattazione di un data set
## ****************************

## Ritorniamo ad X
str(X)

## Colonna 5: è numerica, quindi è ok

## Colonna 4: deve essere una variabile ordinabile (ordered factor)
X$Risk

X$Risk <- factor(X$Risk, levels = c("Low","Medium", "High"), ordered = TRUE)

X$Risk

## Colonna 3: è  una variabile nominale (unordered factor)
X$Gender

X$Gender <- factor(X$Gender, levels = c("F","M"))

X$Gender

## Colonna 2: deve essere trattata come una semplice stringa, quindi è ok


## Colonna 1: sono date nel formato d/m/y, ma
X$Date

## trasformiamo le date in una classe ed in un formato appropriato,
## la scelta ottimale è il formato ISO-8601  (yyyy-mm-dd)
## 
X$Date <- as.Date(X$Date,   format="%d/%m/%y")


## Infatti ora
str(X)










## Scrittura di un data set in formati ASCII
## *****************************************

## Scrittura del data set in un file CSV
write.table(X, file="foo_data_1.csv", sep = "," ,
            row.names = FALSE, col.names = TRUE)


## Scrittura del data set in un file TSV
write.table(X, file="foo_data_2.tsv", sep = "\t" ,
            row.names = FALSE, col.names = TRUE)







## Scrittura di dati in formato RData
## **********************************
## Supponiomo di dover lorare con questi dati in più sessioni, cosa accade se
## la prossima volta? Rileggiamo i dati in formati ASCII perdendo tutta la
## formattazione?
save(X , file="foo_X.RData")




## Operazioni su stringhe
## **********************

## Sostituzione di elementi di una stringa
s1  <- "aaa bbb ccc"

## Sostituzione rispetto a un pattern ben identificato
gsub(pattern = " ", replacement = "_",  x = s1)

## Sostituzione rispetto a regex
gsub(pattern ="[[:lower:]]", replacement = "0", x = s1)

## Tutti i regex sono descritti in help("regex"). Il package "stringr" permette
## operazioni molto complesse che sarebbero difficili da implementare con le
## funzionalità di R base



## Split di una stringa
x <- "Corso di Analisi e Visualizzazione dei dati"
strsplit(x, " ")
strsplit(x, "")


## Numero di caratteri in una stringa
x <- "Pietro"
nchar(x)






## Concatenazione di stringhe
nome     <- "Pietro"
cognome  <- "Coretto"

paste(cognome, nome)

paste(cognome, nome, sep = "")

paste0(cognome, nome)

paste(cognome, nome, sep=", ")

x <- LETTERS
paste(x, collapse = "*-!-*")




## Concatenazione --> console output (print)
m  <- 1800
ct <- "Italia"

cat("Paese = ", ct, "Media del reddito = ", m ,  "euro")

cat("Paese = ", ct, "Media del reddito = ", m ,  "euro", sep = "---")

## Concatenazione -->  file 
cat("Paese = ", ct, "\nMedia del reddito = ", m ,  "euro", sep = "",
    file="foo_cat.txt")


## Print
A <- matrix(1:12, nrow = 3)
A
print(A)


## Print vs cat
cat(A)

cat("La matrice A è\n")
print(A)


## Scrittura di messaggi a schermo
message("Sto eseguendo lo step 1 dell'algoritmo")








## *****************************************************************************
## APPROFONDIMENTI:
## ripeti con attenzione la lezione. Explora i seguenti comandi
## ed assicurati di aver compreso pienamente il risultato dell'esecuzione
## *****************************************************************************


## Importa il data set "foo_X.RData" salvato sopra e controlla che tutti i
## metadati formattati sono stati preservati correttamente



## Importa i data set "foo_data_1.csv"  e "foo_data_e.txt" e controlla se i suoi
## metadati sono formattati correttamente



## Cosa stai calcolando di seguito?
X$Date[3] - X$Date[1]




## Cosa fanno i seguenti comandi?
format(X$Date, "%B")
format(X$Date, "%d %a %B %Y")
Sys.Date()



## Nel seguente comando sostituisci la data con il la tua data di nascita
compleanno <- as.Date("1900/01/01",   format="%Y/%m/%d")
## Cosa sai calcolando di seguito?
Sys.Date() - compleanno
## Vuoi sapere le ore di vita trascorse?
difftime(Sys.Date(), compleanno, units = "hours")




## Crea una lista ed una matrice e salva tutti e due gli oggetti nel file
## foo_AU.RData
U <- list(A=1, B=2, C=NA)
A <- matrix(1:9, ncol = 3, nrow = 3)
save(list=c("U", "X"), file="foo_AU.RData")
##
## Adesso controlla il contenuto del file "foo_AU.RData"



## Esplora le seguenti funzioni/comandi
Sys.Date()
Sys.time()
Sys.info()




## Esegui la seguente lista di comandi
dir.create("C:/ZYX2019")
setwd("C:/ZYX2019")
download.file(url="http://www.decg.it/pcoretto/unisa-avd/syllabus.pdf"
              destfile = "pippo.pdf")
## Adesso controlla il contenuto della directory    C:/ZYX2019, cosa è successo?



## Un esempio utile per manipolare dati
nomi <- c("La Rocca, Michele", "Coretto, Pietro")
tmp <- strsplit(nomi, ", ")
tmp
matrix(unlist(tmp), ncol=2, byrow=TRUE)



