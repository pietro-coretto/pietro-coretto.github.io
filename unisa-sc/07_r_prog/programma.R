## =============================================================================
## Autore:             Pietro Coretto (pcoretto@unisa.it)
## Ultimo aggiornamto: 2019-09-27  15:30:02
##
## Descrizione
## ***********
## * importa il data set
##         https://pietro-coretto.github.io/datasets/apple/apple.dat
## * scrive a schermo alcune informazioni sui dati
## * calcola la media di alcune variabili
## * salva tutta l'area di memoria in un archivio "apple_data_analisi.RData"
## =============================================================================


## Leggi il data set
message("Lettura dati:.... attendere prego,....")
X <- read.table(file=url("https://pietro-coretto.github.io/datasets/apple/apple.dat"),
                header=TRUE)


## Doppio spazio verticale
cat("\n\n")



## Scrive a schermo alcune informazioni sul data set
message("I dati sono stati importati in un oggeto X:\n")
print(str(X))




## Doppio spazio verticale
cat("\n\n")



## Calcola la media di vCap e  VLab
media_C  <- mean(X$vCap)
media_L  <- mean(X$vLab)



## Scrive a schermo
message("The media del costo del capitale è  pari a  ", media_C )
message("The media del costo del lavoro è  ",  media_L )


## Doppio spazio verticale
cat("\n\n")



## Salva l'intero worskpace nella directory locale
message("Salvataggio del workspace in corso.... ")
save.image(file = "apple_data_analisi.RData ")



## Doppio spazio verticale
cat("\n\n")



## Messaggio finale
message("
L'esecuzione di programma.R è terminata con successo.
Tutto il lavoro è stato salvato nel file apple_data_analisi.RData
posizionato nella directory: \n\n \t\t" ,  getwd()
)
