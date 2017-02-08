#########################################################
## Stat 202A - Homework 6
## Author: 
## Date : 
## Description: This script implements QR decomposition
## and linear regression based on QR
#########################################################

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

##################################
## Function 1: QR decomposition ##
##################################

myQR <- function(A){
  
  ## Perform QR factorization on the matrix A
  ## FILL IN CODE HERE ##
  
  n <- dim(A)[1]
  m <- dim(A)[2]
  Q= diag(n)
    
  for(k in 1:(m-1))
  {
    X= rep(0,n)
    X[k:n]= A[k:n,k]
    v= X
    v[k]= X[k]+sign(X[k])* norm(X)
    s= norm(v)
    u= v/s
    A= A - 2 * u %*% (t(u) %*% R)
    Q= Q - 2 * u %*% (t(u) %*% Q)
  }
  
  ## Function should output a list with Q.transpose and R
  return(list("Q" = t(Q), "R" = R))
}

###############################################
## Function 2: Linear regression based on QR ##
###############################################

myLM <- function(X, Y){
  
  ## X is an n x p matrix of explanatory variables
  ## Y is an n dimensional vector of responses
  ## Do NOT simulate data in this function. n and p
  ## should be determined by X.
  ## Use myQR inside of this function
  
  ## FILL CODE HERE ##
  
  
  ## Function returns beta_ls, the least squares
  ## solution vector
  return(beta_ls)

  
}


