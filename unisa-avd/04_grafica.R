## =============================================================================
## Corso          Analisi e Visualizzazione dei Dati [0212800004] / Parte I
## Cdl/Percorso 	Statistica per i Big Data (L41) 
## Docente 	   	  Pietro Coretto (pcoretto@unisa.it)
##
##
##  Argomenti:
##    * device grafico
##    * la funzione generica plot()
##    * parametri comuni della funzione plot
##    * griglie, legenda, etc
##    * overlay
##    * grafici multipli in una stessa finestra grafica
##    * tecniche di rendering: raster vs grafica vettoriale
##    * alcune semplici tecniche di ottimizzazione dei formai grafici
##
## Ultimo aggiornamento: 20-02-2022 at 10:41:17 (CET)
## =============================================================================










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
##    - Low-levelp lotting: funzioni che usano un device grafico esistente
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
plot(x,
     main="Il mio Titolo",
     xlab="Asse delle X", ylab="Asse delle Y")




## Paramtero t = point (default)
## *****************************

plot(x, t="p")

## Parametri ausiliari: tipo di punto, colore, dimensione relativa
plot(x, t="p", pch = "A",  col = 2)

## I colori standard di R sono
colors()

plot(x, t='p', pch = 20,  col = "tomato4", cex = 1)

plot(x, t='p', pch = 20, col = "#D4356C")

plot(x, t='p', pch = 20, col = rgb(0.83, .20, .30))










## Parametro t = l = linea
## ***********************
plot(x, t = "l")

## Parametri ausiliari: spessore, tipo di linea, colore
plot(x, t='l', lwd = 2 , lty = 2 , col = 3)





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
plot(x , y , pch = "+" ,  cex = 2 , col = 1:10 ,
     main = "Grafico XY-Plot",
     xlab = "Variabile X",
     ylab = "Variabile Y")




## ATTENZIONE: il grafic device potrebbe evere un aspect-ratio
## poco adatto. In alcuni casi è necessario assicurarsi che il l'aspect-ratio
## sia adeguato. L'imposizione dei limiti alla scala degli assi non ha
## generalmente effetti correttivi al riguardo
plot(x , y , xlim = c(0,10), ylim = c(0, 10))


## Tuttavia esiste un parametro asp che  controlla l'aspect ratio
plot(x,y, asp = 1)





## Overlay di rette
plot(x,y, asp = 2)
abline(h=5, col=2, lwd = 2, lty = 3)
abline(v=1, col=4, lwd = 2, lty = 5)
## Aggiungiamo una retta di equazione y = 1+2x
abline(coef=c(1,2))









## Codifica dei colori RGB
## ***********************
## possiamo generare tantissimi colori con la funzione rgb()
## essa restituisce il codice HEX di una data mescolanza dei canali
## R G e B
colA <- "#4D80B3" ## = rgb(0.3, 0.5, 0.7)  
colA
colB <- "#9933B3" ## = rgb(0.6, 0.2, 0.7)    
colB
colC <- "#999999" ## = rgb(0.6, 0.6, 0.6)  ## grigio al 60%
colC








## Overlay multipli e tanto altro!
## *******************************
x  <- seq(-4*pi, 4*pi, length=1000)
f1 <- sin(x)
f2 <- cos(x)

## Plot della prima curva
plot(x, f1, t="l", col = colA, lwd = 4,
     main="Funzioni trigonometriche",
     xlab="Radianti", ylab="f(x)")

## Overlay con la seconda curva
lines(x, f2, col=colB, lwd = 4, lty = 3)

## legenda
legend(x="topright", legend=c("sin(x)", "cos(x)")
      , lwd=c(2,2), lty=c(1,3), col=c(colA, colB))

## Griglia
grid(10, 10, lwd = 1 , lty = 4 , col = colC)

## Overlay di punti qualsiasi: vogliamo sovraimporre due punti
## di coordinate (-5,-0.5)   e  (5, 0.5) e segnarli con "+"
px <- c(-5,     5)
py <- c(-0.5, 0.5)
points(px , py , pch = "X", cex =5, col = 2)











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
par(bg = colA)
plot(x)
plot(y)

dev.off()






## Grafici multipli nella stessa finestra grafica
## **********************************************
##
x <- c(0, -1 , 2 , 3 , -4 , 10)
par(mfrow=c(2,2))
plot(x, main='Plot 2')
plot(2*x, t="l" , main='Plot 2')
plot(3*x, t="b" , main='Plot 3')
plot(4*x, t="l" , main='Plot 4')





## Grafica
## *******
## fare grafici funzionali e belli per poi ottenere un rendering meno che decente
## è uno spreco. Un grafico di qualità statistica elevata merita un rendering
## adeguato. Per avere controllo sulla qualità del rendering dobbiamo stare
## attenti a:
##
##  * AR = aspect ratio = larghezza/altezza:
##    è il rapporto tra la diemensione orizzontale e verticale del grafico
##     - i proiettori/monitor da cinema hanno AR = 16/9 oppure 16/10 (=1.6)
##     - i proiettori per presentazione hanno solitamente un AR = 4/3 (=1.33)
##     - i moderni sensori delle camere full-frame hanno AR = 9/6 (=1.5)
##     - un foglio A4 ha un AR = sqrt(2) (=1.4)
##
##  * Presenza di testo: alune tecniche di rendering non si sposano bene con
##    la riproduzione di fonts tipografici
##
##  * risoluzione e grandezza dell'immagine rispetto alla destinazione
##    dell'immagine. Produrre immagini di qualità per la stampa è in genere molto
##    più difficile che produrre immagini di buona qualità per la visualizzazione
##    a video
##
##
##
## Grafica Raster/Bitmap
## *********************
##
##  L'immagine viene parcellizzata in aree più piccole: pixels
##  punti. In un immagine raster devo memorizzare il colore di ogni pixel
##  (orizzontali x verticali).
##
##   Pro:
##     -compressione è semplice efficace
##     -conveniente in termini di memoria se l'immagine contiene troppi dettagli
##      trascurabili
##     -particolarmente adatta per il web quando non si richiede estremo dettaglio
##
##   Con:
##    -il rendering dei font tipografici è solitamente scadente
##    -poco adatta alla compressione quando ci sono molti dettagli
##    -non consente di riscalare senza perdere la qualità del dettaglio
##
##    Formati e comressioni: jpeg, png, gif, ...
##
## Grafica Vettoriale
## *******************
##
##  Gli oggetti dell'immagine sono descritti da matematicamente, ad
##  esempio un segmento è descritto da y = a + b*x, i font sono incorporati in un
##  database agganciato al file, etc.
##
##   Pro:
##    -consentono un grande dettaglio
##    -particolamrmente adatti in immagini ricche di testo
##    -si possono cambiare le dimenisoni fisiche dell'immagine senza perdita di
##     dettaglio.
##
##   Con:
##    -immagini ricche di dettaglio possono avere dimensioni enormi
##    -la compressione lossy non ha effetti
##    -poco adatte alla grafica web
##
##    Formati vettoriali: pdf, svg, dxf, eps, , ...



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
jpeg(filename = "pics_A_72.jpg",
     width = 500, height = 375, units = "px", res = 72,
     pointsize = 12, quality = 75)
## Scriviamoci dentro il plot
plot(x, y, t='l', main = "Funzione potenza")
## Chiudiamo il device grafico
dev.off()






## Attenzione:
##  * Aspect ratio: (width / height) = AR. In questo caso AR = 800/600 = 4/3
##  * Risoluzione: res = ppi = pixel in ogni inch, 1inch = 25.4mm
##
## Proviamo  ad aumentare la risoluzione, e lasciamo invarito width, height, e AR
## nota 300ppi è la risoluzione usata nella foto professionale
##
jpeg(filename = "pics_A_300_1.jpg",
     width =500, height = 375 , units = "px", res = 300,
     pointsize = 12, quality = 75)
x11()
plot(x, y, t='l', main = "Funzione potenza")
dev.off()





## Strategia per ottenere grafici bitmap di buona risoluzione 
## con un font  proporziato 
## -----------------------------------------------------------

## fissiamo l'aspect ratio 
ar <- sqrt(2)  ## oppure 16/9 , 4/3 , 1.618


## fissiamo l'altezza fisica  tra il 33% e il 50% dell'altezza di un foglio A4 
## 297mm * 0.33 = 98 mm
## 297mm * 0.50 = 148.5 mm
h  <- 150 ## mm


## stampiamo il jpeg/png usando una densità di px professionale (300) ed un
## font di 12pt proporzionato 
jpeg(filename = "pics_A_300_12.jpg",
     height = h ,  width = h*ar , units = "mm", res = 300, pointsize = 12, 
     quality = 75)
## Scriviamoci dentro il plot
plot(x, y, t='l', main = "Funzione potenza")
## Chiudiamo il device grafico
dev.off()


## stessa procedura per ottenere il  formato png
png(filename = "pics_300_12.png",
    height = h ,  width = h*ar , units = "mm", res = 300, pointsize = 12)
## Scriviamoci dentro il plot
plot(x, y, t='l', main = "Funzione potenza")
## Chiudiamo il device grafico
dev.off()




## Scrivere il grafico in formato PDF (vettoriale)
##
##  * formato vettoriale
##  * ATTENZIONE: le dimensioni sono specificate in inches
##    (1 inch = 24.5mm = 2.54cm)

## trasformiamo le dimensioni di prima in mm in inches
hh <- h / 25.4
ww <- hh * ar

pdf(file = "pics_3.pdf", height   = hh  , width = ww ,  pointsize = 12)
plot(x, y, t='l', main = "Funzione potenza")
dev.off()















## =============================================================================
## APPROFONDIMENTI:
## ripeti con attenzione la lezione. Explora i seguenti comandi
## ed assicurati di aver compreso pienamente il risultato dell'esecuzione
## =============================================================================


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



