############################################################# 
## Stat 202A - Homework 3
## Author: 
## Date : 
## Description: This script implements the lasso
#############################################################

#############################################################
## INSTRUCTIONS: Please fill in the missing lines of code
## only where specified. Do not change function names, 
## function inputs or outputs. You can add examples at the
## end of the script (in the "Optional examples" section) to 
## double-check your work, but MAKE SURE TO COMMENT OUT ALL 
## OF YOUR EXAMPLES BEFORE SUBMITTING.
##
## Very important: Do not change the working directory anywhere
## in your code. If you do, I will be unable to grade your 
## work since Python will attempt to change my working directory
## to one that does not exist.
#############################################################

import numpy as np

#####################################
## Function 1: Lasso solution path ##
#####################################

def myLasso(X, Y, lambda_all):
  
  # Find the lasso solution path for various values of 
  # the regularization parameter lambda.
  # 
  # X: Array of explanatory variables.
  # Y: Response array
  # lambda_all: Array of regularization parameters. Make sure 
  # to sort lambda_all in decreasing order for efficiency.
  #
  # Returns an array containing the lasso solution  
  # beta for each regularization parameter.
 
    (n, p)= np.shape(X)
    T= 10 # iterate for each lambda; set arbitrarily
    L= len(lambda_all)

    beta= [0 for j in range(p)] 
    beta_all= [[0 for l in range(L)] for j in range(p)] 
  
    ss= []
    for j in range(p):
        ss.append( sum([X[i][j]**2 for i in range(n)]) ) # simply x^2

    R= np.copy(Y)
    for l in range(L):
        lam= lambda_all[l] # lambda
        for t in range(T):
            for j in range(p):
                db= np.dot(R, [ X[i][j] for i in range(n) ]) /ss[j]
                b= beta[j]+db
                b= np.sign(b) * max( (0, abs(b)-lam/ss[j]) )
                db= b-beta[j]
                R= [ R[i] - db * X[i][j] for i in range(n) ]
                beta[j]= b
        for j in range(p):
            for l in range(l):
                beta_all[j,l]= beta[j]

  ## Function should output the array beta_all, the 
  ## solution to the lasso regression problem for all
  ## the regularization parameters. 
  ## beta_all is p x length(lambda_all)
    return(beta_all)

# main
#n= 100
#p= 50

#beta_true= [0 for i in range(p)]
#beta_true[0:5]= [1, 2, 3, 4, 5]
#x= [ np.random.normal(0, 1, p) for i in range(n)]
#y= np.dot(x, beta_true) + np.random.normal(0, 1, n)
#lambda_all= [i*10 in range(100,-1,-1)]
#beta_out= myLasso(x, y, lambda_all)
#print beta_out
