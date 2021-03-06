############################################################# 
## Stat 202A - Homework 4
## Author: 
## Date : 
## Description: This script implements stagewise regression
## (epsilon boosting)
#############################################################

#############################################################
## INSTRUCTIONS: Please fill in the missing lines of code
## only where specified. Do not change function names, 
## function inputs or outputs. You can add examples at the
## end of the script (in the "Optional examples" section) to 
## double-check your work, but MAKE SURE TO COMMENT OUT ALL 
## OF YOUR EXAMPLES BEFORE SUBMITTING.
##
## Very important: Do not use the function "setwd" anywhere
## in your code. If you do, I will be unable to grade your 
## work since R will attempt to change my working directory
## to one that does not exist.
#############################################################

######################################
## Function 1: Stagewise regression ##
######################################

swRegression <- function(X, Y, numIter = 3000, epsilon = 0.0001){
  
  # Perform stagewise regression (epsilon boosting) of Y on X
  # 
  # X: Matrix of explanatory variables.
  # Y: Response vector
  # numIter: Number of iterations ("T" in class notes)
  # epsilon: Update step size (should be small)
  #
  # Returns a matrix containing the stepwise solution vector 
  # for each iteration.
  
  #######################
  ## FILL IN WITH CODE ##
  #######################
  
  n= dim(X)[1]
  p= dim(X)[2]
  
  db= rep(0,p)
  beta= matrix(rep(0,p), nrow=p)
  beta_all= matrix(rep(0,p*numIter), nrow=p)
  R= Y
  for(t in 1:numIter){
    for(j in 1:p)
      db[j]= sum(R*X[,j])
    j= which.max(abs(db))
    beta[j]= beta[j]+db[j]*epsilon
    R= R-X[,j]*db[j]*epsilon
    
    beta_all[,t]= beta
  }
  
  ## Function should output the matrix beta_all, the 
  ## solution to the stagewise regression problem.
  ## beta_all is p x numIter
  return(beta_all)
  
}

#n= 100
#p= 1000
#s= 10

#X= matrix(rnorm(n*p), nrow= n)
#beta_true= matrix(rep(0, p), nrow= p)
#beta_true[1:5]= 1:5
#Y= X %*% beta_true + rnorm(n)

#beta_out= swRegression(X, Y)
#plot(beta_out[1,], col= 'red', ylim= c(0, 10))
#points(beta_out[2,], col='orange')
#points(beta_out[3,], col='green')
#points(beta_out[4,], col='blue')
#points(beta_out[5,], col='purple')
#points(beta_out[6,], col='yellow')
#points(beta_out[6,], col='orange')
#points(beta_out[10,])
#points(beta_out[20,])
#points(beta_out[30,])
#points(beta_out[77,])

