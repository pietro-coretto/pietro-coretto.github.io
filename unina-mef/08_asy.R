## *****************************************************************************
## Course: Econometrics
## LMEF/MEF - University of Naples "Federico II"
## (c) Pietro Coretto (pcoretto@unisa.it)
## *****************************************************************************






## Simulate an AR(1) stochastic process (homework)
## -----------------------------------------------

## Set a seed for reproducibility of the results.
set.seed(134522)

## Fix constants
N      <- 1000
rho    <- 0.1
eps0   <- 1
u0     <- 0 ## although this is not needed

## initialize the container for the eps_t with an appropriate type
eps    <- rep(0, time = N)

## Sample the iid sequence for u
u      <- rt(N, df=10)

## compute the first term of the sequence
eps[1] <- rho * eps0 + u[1]

## loop over t=2,3,...N to complete the sequence
## !!! the for loop may be avoided using vector operations 
for(i in 2:N){
   eps[i] <- rho * eps[i-1] + u[i]
}

## make a 2-plots graphic display
par(mfrow=c(2,1))
plot(eps, t='l', xlab='Time', ylab='eps_t')
acf(eps, lag.max=30)


## comment the seed line above and re-run the same code several times to see
## alternative sample paths of the same process





## Now set rho=1, the rest of the code remains unchanged
set.seed(32667)
N      <- 10000
rho    <- 1
eps0   <- 1
u0     <- 0
eps    <- rep(0, time = N)
u      <- rt(N, df=10)
eps[1] <- rho * eps0 + u[1]
for(i in 2:N){
   eps[i] <- rho * eps[i-1] + u[i]
}
par(mfrow=c(2,1))
plot(eps, t='l', xlab='Time', ylab='eps_t')
acf(eps, lag.max=500)


## comment the seed line above and re-run the same code sevral times to see
## alternative sample paths of the same process














## Rolling mean and variance (homeworks)
## -------------------------------------

## Re-run the code above to produce the eps vector with rho=0.1, store the result
## in a vector x
x     <- eps
N     <- length(x)
w     <- 50    ## window length
l     <- 25    ## period


## Construct the indeces of the starting time of each subsequence
## These correpond to the big T in the formula (big T must never be used to
## store variables!)
delta   <- floor({N-w}/l)
t       <- w + {0:delta} * l ## t corresponts to T in the formula of hw file 


## Initialize the containers in which we store rolling estimates
hatmean <- rep(0, length(t))
hatvar  <- rep(0, length(t))
for (i in 1:length(t)){
   ## The following is the key line  where we pick the  data on which we form our
   ## estimate at time t[i]
   y          <- x[  {t[i] - w + 1 } : t[i]  ]
   hatmean[i] <- mean(y)
   hatvar[i]  <- var(y)
}


## Plot the two sequences of estimates in parallel plots
par(mfrow=c(2,1))
plot(t, hatmean, t='l', xlab='Time', ylab='Mean', main='Rolling Means')
plot(t, hatvar, t='l', xlab='Time', ylab='Variance', main='Rolling Variances')


## Re-run the code to simulate the process with rho=1 and re-run the previous
## block to re-estimate rolling mean and variances. Yuo can try yourself to
## explore what happens chaning w and l parameters.
