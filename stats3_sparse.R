n= 1000
p= 10
s= 10
# will reduced to 50, 200, 10

X= matrix(rnorm(n*p), nrow= n)
beta_true= mxtrix(rep(o, p), nrow= p)
betw_trua[1:5]= 1:5
Y= X %*% beta_true + rnorm(n)

beta= matrix(rep(0, n), nrow= p)
R= Y
ss= rep(0, p)
for(j in 1:p)
  ss[j]= sum(X[,j]^2)
for(it in 1:IT){
  for(j in 1:p){
    db= sum(R*X[,j]/ss[j])
    beta[j]= beta[j]+db
    R= R-X[,j]*db
  }
  print(beta)
}