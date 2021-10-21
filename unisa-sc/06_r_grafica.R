## =============================================================================
## Corso:          Statistica computazionale 
## Cdl/Percorso:   Management e Informatica
## Docente:        Pietro Coretto (pcoretto@unisa.it)
##
## Argomenti:
##   + tecniche elementari per manipolare stringhe 
##   + gestione dell’output della console 
##   + introduzione al device grafico di R 
##   + parametri grafici generici 
##   + scrittura di grafici in formati comuni (pdf, jpg, png)
## =============================================================================



## Operazioni su stringhe
## **********************

## Sostituzione di elementi di una stringa
s1  <- "aaa bbb ccc"

## Sostituzione rispetto a un pattern ben identificato
gsub(pattern = " ", replacement = "_",  x = s1)

## Sostituzione rispetto a regex
gsub(pattern ="aaa", replacement = "boooo", x = s1)

## Split di una stringa
x <- "Corso di Statistica Comoutazionale"
strsplit(x, " ")
strsplit(x, "")

x <- c("Corso di SC", "aa 2020/21")
strsplit(x, "/")

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
x
u <- paste(x, collapse = "|--|")
u

## creazione di stringhe a sequenze 
u <- paste("A", 1:10, sep="/")
u





## Concatenazione e scrittura
m  <- 1500
ct <- "Italia"

cat("Paese = ", ct, "Media del reddito = ", m ,  "euro")

cat("Paese = ", ct, "Media del reddito = ", m ,  "euro", sep = "---")


## Strittura di elementi concatenati in un file di testo
    cat("Paese = ", ct, "\nMedia del reddito = ", m ,  "euro", sep = "",
        file="foo_cat.txt")

cat("\nbooooo", sep = "", file="foo_cat.txt")


## cat append 
cat("\nQuesto è il primo cat\tAAAA\tBBBB", sep = "", 
    file="foo_cat.txt", append = TRUE)
cat("\nQuesto è il secondo cat\tCCCC\tDDDDD", sep = "", 
    file="foo_cat.txt", append = TRUE)


## combinazione di paste and cat
u <- paste("Ciccio è tornato", "a casa") 
cat(u)






## Print = visualizzare un oggetto 
A <- matrix(1:12, nrow = 3)
print(A)

## Print vs cat
cat(A)

cat("La matrice A è\n")
print(A)


## Scrittura di messaggi a schermo
i <- 100
message("Sto eseguendo lo step ", i , " dell'algoritmo")











## Device grafico
## **************
##
## * La grafica è una parte essenziale di R e della metodologia statistica
##
## * La grafica può essere utilizzata in tutte e due le modalità tipiche
##   di una sessione di lavoro in R: interactive o  batch
##
## * Quando iniziamo una sessione di R, in automatico viene inizializzato
##   un "device grafico". Ogni chiamata al device grafico produce in automatico
##   una call a
##    - X11() per sistemi linux/unix
##    - quartz() per sistemi macOS
##    - windows() per sistemi MS Windows
##   questi comandi sono dipendenti dall'OS.
##
##  * I comandi di plotting si dividono in tre tipi
##    - High-level plotting: funzioni che creano un nuovo grafico in un
##      device grafico dedicato
##    - Low-level lotting: funzioni che usano un device grafico esistente
##      per aggiungere elementi
##    - Interactive graphics: funzioni che rendono possibile l'interazione
##      tra il device grafico e l'utente
##
##  * La maggior parte delle funzioni di plotting seguiono una logica
##    Object-oriented (OO). Una funzione generica legge i parametri input,
##    una volta determinata la "classe" degli input decide cosa inviare
##    al graphic-device




## Plot: funzione generica
## ***********************
x  <- c(-1,-3, 0, 4, 7, 9, 10, 1, 22, 1, 0, -6, 8, 10)
plot(x)


## Parametri generici: titolo del grafico e labels degli assi
plot(x, main="Il mio Titolo", xlab="Asse delle X", ylab="Asse delle Y")




## Paramtero t = point (default)
## *****************************

plot(x, t="p")

## Parametri ausiliari: tipo di punto, colore, dimensione relativa
plot(x, t="p", pch = 5,  col = 2)

plot(x, t='p', pch = "X",  col = "cyan", cex = 4)

## I colori  catalogati in di R sono 657:
colors()

## I colori possono essere anche indicati con il loro codice HEX
## vedi: https://htmlcolorcodes.com/
plot(x, t='p', pch = 20, col = "#d35400", cex=2)

## Oppure usando il miscelatore RGB
plot(x, t='p', pch = 20, col = rgb(211/255, 84/255, 0))










## Parametro t = l = linea
## ***********************
plot(x, t = "l")

## Parametri ausiliari: spessore, tipo di linea, colore
plot(x, t='l', lwd = 2 , lty = 4 , col = 3)


## Parametro t = b = "both" = linea e punto
## ****************************************
plot(x, t='b')


## Parametri ausiliari: tutti i parametri precedenti
plot(x, t='b', lty =5, pch = 20, cex=2, col=4)







## xy-plot
## *******
x <- c(3, 1, 5, 1, 0, 5 , 7 , 6 , 2, 1)
y <- c(1, 4, 2,-3, 8, 10, 9,  7 , 1, 0)
plot(x,y)


## Tutti i parametri precenti funzionano allo stesso modo
plot(x , y , pch = "*" ,  cex = 2 , col = 1:10 ,
     main = "Grafico XY-Plot",
     xlab = "Variabile X",
     ylab = "Variabile Y")




## ATTENZIONE: il grafic device potrebbe evere un aspect-ratio
## poco adatto. In alcuni casi è necessario assicurarsi che il l'aspect-ratio
## sia adeguato. L'imposizione dei limiti alla scala degli assi non ha
## generalmente effetti correttivi al riguardo
plot(x , y , xlim = c(0,10), ylim = c(0, 10))







## Overlay di rette
plot(x,y, asp = 1)
abline(h=5, col=2, lwd = 2, lty = 3)
abline(v=1, col=4, lwd = 2, lty = 5)
## Aggiungiamo una retta di equazione y = 1+2x
abline(coef=c(1,2))









## Codifica dei colori RGB
## ***********************
## possiamo generare tantissimi colori con la funzione rgb()
## essa restituisce il codice HEX di una data mescolanza dei canali
## R G e B
colA <- rgb(0.3, 0.5, 0.7)
colA
colB <- rgb(0.6, 0.2, 0.7)
colB
colC <- rgb(0.6, 0.6, 0.6) ## grigio al 60%
colC








## Overlay multipli e tanto altro!
## *******************************
x  <- seq(-4*pi, 4*pi, length=1000)
f1 <- sin(x)


## Plot della prima curva
plot(x, f1, t="l", col = colA, lwd = 4,
     main="Funzioni trigonometriche",
     xlab="Radianti", ylab="f(x)")

## Overlay con la seconda curva
f2 <- cos(x)
lines(x, f2, col=colB, lwd = 4, lty = 3)

## legenda
legend(x="topright", legend=c("sin(x)", "cos(x)")
       , lwd=c(2,2), lty=c(1,3), col=c(colA, colB))

## Griglia
grid(10, 10, lwd = 1 , lty = 4 , col = colC)

## Overlay di punti qualsiasi: vogliamo sovraimporre due punti
## di coordinate (-5,-0.5)   e  (5, 0.5) e segnarli con "+"
px <- c(-5, 5)
py <- c(-0.5, 0.5)
points(px , py , pch = 3, cex =5, col = 2)











## Axis labels
## ******************************************************
## Supponiamo di avere i seguenti dati in "serie storica"
mese     <- c("Gen" , "Feb" , "Mar" , "Apr" , "Mag")
consumo  <- c(100   ,  115  , 125   ,   98  , 95)

## Attenzione
plot(mese , consumo , t="l")

## Prima produciamo un plot escludendo gli assi
plot(x = 1:5 ,  y = consumo , t = "b" , axes=FALSE ,
     main = "Serie Storica dei consumi",
     xlab = "Mese",
     ylab = "Consumo [euro]")

# Aggiungiamo l'asse orizontale
axis(1, at = 1:5, labels = mese , las=1)
## Aggiungiamo l'asse verticale, se non diamo parametri R provvede a calcolare
## valori di default per at e labels
axis(2)

## Possiamo aggiungere il frame
box()








## La funzione par()
## *****************
##
##  * par() gestisce tutti i 72 parametri della finestra grafica
##  * i parametri di default si possono modificare andando a modificare gli elementi
##    di par()
##  * l'help  ?par() contiene una disamina esaustiva

par()

## Esempio: per tutti i grafici voglio cambiare il colore in background
par(bg = "grey90")
plot(consumo)







## Grafici multipli nella stessa finestra grafica
## **********************************************
##
x <- c(0, -1 , 2 , 3 , -4 , 10)
par(mfrow=c(2,2))
plot(x, main='Plot 2')
plot(2*x, t="l" , main='Plot 2')
plot(3*x, t="b" , main='Plot 3')
plot(4*x, t="l" , main='Plot 4')



## Reset del device grafico
dev.off()







## Esportare file grafici in R
## ***************************
x <- seq(0,5, length = 100)
y <- x^2
plot(x, y, t='l', main = "Funzione potenza")





## Scrivere il grafico in formato JPEG
##  * grafica bitmap/raster
##  * compressione lossy
##
## Apriamo un file jpeg
jpeg(filename = "plot_1.jpg",
     height = 120,  width = 180, units = "mm", res = 300,
     pointsize = 12, quality = 75)
## Scriviamoci dentro il plot
plot(x, y, t='l', main = "Funzione potenza")
## Chiudiamo il device grafico
dev.off()





## Scrivere il grafico in formato PNG
##
##   * grafica bitmap/raster
##   * compressione lossless
##
png(filename = "plot_2.png",
    height = 120 , width = 180,  units = "mm", res = 300,
    pointsize = 12)
## Scriviamoci dentro il plot
plot(x, y, t='l', main = "Funzione potenza")
## Chiudiamo il device grafico
dev.off()





## Scrivere il grafico in formato PDF
##
##  * formato vettoriale
##  * ATTENZIONE: le dimensioni sono specificate in inches
##    (1 inch = 24.5mm = 2.54cm)
##
pdf(file = "plot_3.pdf",
    height = 120/25.4 , width = 180/25.4 ,  pointsize = 12)
plot(x, y, t='l', main = "Funzione potenza")
dev.off()













## *****************************************************************************
## ESERCIZI:
## ripeti con attenzione la lezione. Explora i seguenti comandi
## ed assicurati di aver compreso pienamente il risultato dell'esecuzione
## *****************************************************************************

## Un esempio utile: supponiamo di aver caricato dei records dove le unità sono 
## registrate con l'identificativo "Cognome, Nome". 
cn <- c("Fantozzi, Ugo", "Baudaffi, Pasquale")
cn

## Vogliamo ottenere i Cognomi ed i nomi in due vettori separati
tmp <- strsplit(cn, ", ")
tmp
cognome <- c(tmp[[1]][1] , tmp[[2]][1])
nome    <- c(tmp[[1]][2] , tmp[[2]][2])

cognome
nome



## Altri tipi meno frequenti: sperimentare i seguenti comandi
x <- 1:5
y <- c(-3,1,0,-3,1)
plot(x, y , t="o")
plot(x, y , t="c")
plot(x, y , t="h")
plot(x, y , t="s")
plot(x, y , t="S")




## Riprendi l'esempio precendente
## Supponiamo di avere i seguenti dati in "serie storica"
mese     <- c("Gen" , "Feb" , "Mar" , "Apr" , "Mag")
consumo  <- c(100   ,  115  , 125   ,   98  , 95)
plot(x = 1:5 ,  y = consumo , t = "b" , axes=FALSE)
axis(1, at = 1:5, labels = mese , las=1)
axis(2)



## Cosa fanno i seguenti comandi?
axis(3, at = 1:5, labels = mese , las=1 , col = 2)
axis(4 , at = c(95, 110, 125), labels = c("A", "B" , "C"))

## Prova a variare il parametro "las" nell'ultimo esempio
