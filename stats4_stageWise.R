n= 1000
p= 100
s= 10
T= 10000

X= matrix(rnorm(n*p), nrow= n)
beta_true= matrix(rep(0, p), nrow= p)
beta_true[1:5]= 1:5
Y= X %*% beta_true + rnorm(n)

db= rep(0,p)
beta= matrix(rep(0,p), nrow=p)
epsilon= .0001
R= Y
for(t in 1:T){
  for(j in 1:p)
    db[j]= sum(R*X[,j])
  j= which.max(abs(db))
  beta[j]= beta[j]+db[j]*epsilon
  R= R-X[,j]*db[j]*epsilon
}
print(beta)