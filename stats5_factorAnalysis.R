# initialize values
n= 1000
p= 5
d= 2
sigma= 1
T= 1000
w_true= matrix(rnorm(d*p), nrpw= p)
z_true= matrix(rnorm(n*d), nrow= d)
epsilon= matrix(rnorm(p*n)*sigma, nrow= p)
X= w_true %*% z_true + epsilon

sq= 1
XX= X %*% t(X)
w= matrix(rnorm(p*d)*1, nrow= p)
for(t in 1:T){
  A= rbind(cbind(t(w) %*% w/sq + diag(d), t(w)/sq), cbind(w/sq, diag(p)))
  As= mySweep(A, d)
  alpha= As[1:d, (d+1):(d+p)]
  V= -As[1:d, 1:d]
  Zh= alpha %*% X
  ZZ= Zh %*% t(Zh) + V*n
  B= rbind(cbind(ZZ, Zh %*% t(X)))
  Bs= mySweep(B, d)
  w= t(Bs[1:d, (d+1):(d+p)])
  sq= mean(diag(Bs[(d+1):(d+p), (d+1):(d+p)]))/n
}

print(W)