"""
Stat 202A - Homework 1
Author: 
Date : 
Description: This script implements the sweep operator as
well as Gauss-Jordan elimination in both plain and
vectorized form

INSTRUCTIONS: Please fill in the missing lines of code
only where specified. Do not change function names, 
function inputs or outputs. You can add examples at the
end of the script to double-check your work, but MAKE 
SURE TO COMMENT OUT ALL OF YOUR EXAMPLES BEFORE SUBMITTING.

Also, whenever I refer to matrix in this python code,
I am basically referring to an array (np.array)

Very important: Do not change the working directory in your code. 
If you do, I will be unable to grade your 
work since Python will attempt to change my working directory
to one that does not exist.
"""

## Import numpy so we can use mathematical objects
## If you need other libraries go ahead and load them as well
import numpy as np


""" Problem 1 """


""" Function 1: Sweep operation """
def mySweep(A, m):
    """
    Perform a SWEEP operation on A with the pivot element A[m,m].
    
    A: a square matrix.
    m: the pivot element is A[m, m].
    : Returns a swept matrix. Original matrix is unchanged.
    """
    
    ## Copy matrix A into B so that A is unchangeed.
    B = np.copy(A)   
    
    """ Fill in the body of this function! """
    n, c= B.shape
    
    for i in range(n): # i != k
        for j in range(n):
            if i!=m and j!=m:
                B[i,j] = B[i,j]-B[i,m]*B[m,j]/B[m,m]
        
    for i in range(n): # Bik
        if i!=m:
            B[i,m]=B[i,m]/B[m,m]
        
    for j in range(n): # Bkj
        if j!=m:
            B[m,j]=B[m,j]/B[m,m]
        
    B[m,m]= -1/B[m,m]

    """ Returns swept matrix B. Output should be an array / np.array / 
    numpy.ndarray, basically an array of some sort"""
    return B
    
    
""" Function 2: Use sweep operation to find determinant """
    
def myDet(A):
    """
    Compute the determinant of A using the sweep operation.
    
    A: a square matrix.
    : Returns the determinant of A.
    """
    
    ## Copy matrix A into B so that A is unchangeed.
    B = np.copy(A)

    n, c= B.shape
    det= 1
    
    for k in range(n):
        det= det*B[k,k]
        B= mySweep(B,k)
    
    """ Fill in the body of this function! """
    
    
    """ Returns the determinant of A. This should be a number, 
     e.g. of class numpy.float """
    return(det)
    
    
""" Problem 2 """


""" Function 3: Elementwise version of Gauss Jordan """   
def myGaussJordan(A, m):
    
    """ Perform Gauss Jordan elimination on A.
    A: a square matrix.
    m: Number of diagonal elements to loop through.
    """
  
    """FILL IN THE BODY OF THIS FUNCTION """

    n, c= A.shape
    B= np.hstack((A, np.identity(n)))
   
    for k in range(m):
        a= B[k,k]
        for j in range(n*2):
            B[k,j]= B[k,j]/a
        for i in range(n):
            if i!=k:
                a= B[i,k]
                for j in range(n*2):
                    B[i,j]= B[i,j]-B[k,j]*a
    
    """ Function returns the matrix (aka array) B """
    return B    
    
    
""" Function 4: Vectorized version of Gauss Jordan """    
def myGaussJordanVec(A, m):
    
    """ Perform Gauss Jordan elimination on A.
    A: a square matrix.
    m: Number of diagonal elements to loop through.
    """
  
    """FILL IN THE BODY OF THIS FUNCTION """
    
    n= A.shape[0]
    B= np.hstack((A, np.identity(n)))
    for k in range(m):
        B[k,:]= B[k,:]/B[k,k]
        for i in range(n):
            if i!=k:
                B[i,:]=B[i,:]-B[k,:]*B[i,k]
    
    
    """ Function returns the matrix (aka array) B """
    return B    


""" Optional examples (comment out before submitting!) """
#A = np.array([[1, 2, 3], [7, 11, 13], [17, 21, 23]], dtype = float).T
#B= np.copy(A)
#print np.linalg.inv(A)
#for s in range(3):
#    B= mySweep(B, s)
#print B
#print myGaussJordan(A, 3)
#print myGaussJordanVec(A, 3)
