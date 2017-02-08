############################################################# 
## Stat 202A - Homework 5
## Author: 
## Date : 
## Description: This script implements factor analysis and 
## matrix completion
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


def mySweep(A, m):
    """
    Perform a SWEEP operation on A with the pivot element A[m,m].
    
    :param A: a square matrix.
    :param m: the pivot element is A[m, m].
    :returns a swept matrix. Original matrix is unchanged.
    """
    
    ## No need to change anything here
    B = np.copy(A)   
    n = B.shape[0]
    for k in range(m):
        for i in range(n):
            for j in range(n):
                if i!=k and j!=k:
                    B[i,j] = B[i,j] - B[i,k]*B[k,j] / B[k,k]
        for i in range(n):
            if i!=k:
                 B[i,k] = B[i,k] / B[k,k]
        for j in range(n):
            if j!=k:
                B[k,j] = B[k,j] / B[k,k]
        B[k,k] = -1/B[k,k]
    
    return(B)

    
def factorAnalysis(n = 10, p = 5, d = 2, sigma = 1, nIter = 1000):
   
    """
    Perform factor analysis on simulated data.
    Simulate data X from the factor analysis model, e.g. 
    X = Z_true * W.T + epsilon
    where W_true is p * d loading matrix (numpy array), Z_true is a n * d matrix 
    (numpy array) of latent factors (assumed normal(0, I)), and epsilon is iid 
    normal(0, sigma^2) noise. You can assume that W_true is normal(0, I)
    
    :param n: Sample size.
    :param p: Number of variables
    :param d: Number of latent factors
    :param sigma: Standard deviation of noise
    :param nIter: Number of iterations
    """

    ## FILL CODE HERE

    # create simulated data
    w_true=  np.random.normal(0, 1, d*p).reshape(p, d)
    z_true=  np.random.normal(0, 1, n*d).reshape(d, n)
    epsilon= np.random.normal(0, 1, p*n).reshape(p, n)
    X= np.dot(w_true, z_true) + epsilon

    # FA
    sq= 1
    XX= np.dot(X, X.T)
    w= np.random.normal(0, 1, p*d).reshape(p, d)
    for t in range(nIter):
        A= np.vstack( np.hstack(np.dot(w.T, w/sq)+d.diagonal(), tw.T/sq), np.hstack(w/sq, p.diagonal()) )
        As= mySweep(A, d)
        alpha= As[0:d, d:(d+p)]
        V= -As[0:d, 0:d]
        Zh= np.dot(alpha, X)
        ZZ= np.dot(Zh, Zh.T) + V*n
        B = np.vstack(np.hstack(ZZ, np.dot(Zh, X.T)), np.hstack(np.dot(X, Zh.T), XX))
        Bs= mySweep(B, d)
        w= Bs[0:d, d:(d+p)].T
        sq= np.mean(np.diagonal(Bs[d:(d+p), d:(d+p)]))/n

    ## Return the p * d np.array w, the estimate of the loading matrix
    return(w)
    
    
def matrixCompletion(n = 200, p = 100, d = 3, sigma = 0.1, nIter = 100,
                     prob = 0.2, lam = 0.1):
   
    """
    Perform matrix completion on simulated data.
    Simulate data X from the factor analysis model, e.g. 
    X = Z_true * W.T + epsilon
    where W_true is p * d loading matrix (numpy array), Z_true is a n * d matrix 
    (numpy array) of latent factors (assumed normal(0, I)), and epsilon is iid 
    normal(0, sigma^2) noise. You can assume that W_true is normal(0, I)
    
    :param n: Sample size.
    :param p: Number of variables
    :param d: Number of latent factors
    :param sigma: Standard deviation of noise
    :param nIter: Number of iterations
    :param prob: Probability that an entry of the matrix X is not missing
    :param lam: Regularization parameter
    """

    ## FILL CODE HERE
    w_true=  np.random.normal(0, 1, d*p).reshape(p, d)
    z_true=  np.random.normal(0, 1, n*d).reshape(d, n)
    epsilon= np.random.normal(0, 1, p*n).reshape(p, n)
    X= np.dot(w_true, z_true) + epsilon

    R= np.random.rand(p, n)
    for i in range(p):
        for j in range(n):
            if R[i, j]<prob: R[i, j]= 1
            else:            R[i, j]= 0
    W= np.random.normal(0, 1, p*d).reshape(p, d)
    Z= np.random.normal(0, 1, n*d).reshape(d, n)

    for it in 1:nIter:
        for i in range(n):
            WW = np.dot(W.T, np.diagonal(R[:,i]), W) + lam*np.diagonal(d)
            WX = np.dot(W.T, np.diagobal(R[:,i]), X[:,i])
            A = np.vstack(np.hstack(WW, WX), np.hstack(WX.T, np.zeros()))
            AS = mySweep(A, d)
            Z[,i] = AS[1:d, d+1]
        for j in range(p):
            ZZ = Z%*%diag(R[j, ])%*%t(Z)+lam* np.diag(d)
            ZX = Z%*%diag(R[j,])%*%X[j,]
            B = rbind(cbind(ZZ, ZX), cbind(t(ZX), 0))
            BS = mySweep(B, d)
            W[j,] = BS[1:d, d+1]
        sd1 = sqrt(sum(R*(X-W%*%Z)^2)/sum(R))
        sd0 = sqrt(sum((1.-R)*(X-W%*%Z)^2)/sum(1.-R))
    
    ## Return estimates of Z and W (both numpy arrays)
    return Z, W  
    
    
    

###########################################################
### Optional examples (comment out before submitting!!) ###
###########################################################
    
