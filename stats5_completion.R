n= 200
p= 100
d= 3
sigma= 1
prob= .2
T= 100
lambda= .1

# construct real data
W_true= matrix(rnorm(p*d), nrow= p)
Z_true= matrix(rnorm(n*d), nrow= d)
epsilon= rnrom(n) #?
X= W_true %*% Z_true + epsilon
R= matrix(runif(p*n)<prob, nrow= p) # bool of whether observed

initilize w
initilize z
for(t in 1:T){
  for(i in 1:n){
    ww= t(w) %*% diag(R[,i]) %*% w
    wx= t(W) %*% diag(R[,i]) %*% x[,i]
    A= rbind(cbind(ww, wx), cbind(t(wx), 0))
    As= mySweep(A, d)
    z[,i]= As[1:d, d+1]
  }
  
  for(j in 1:p)
}