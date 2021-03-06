# making data
n= 50
p= 200
s= 10 # number of non-zero beta
T= 10 # iteration for each lambda
lambda_all= (100:1)*10
L= length(lambda_all)
X= matrix(rnorm(n*p), nrow=n)
beta_true= matrix(rep(0,p), nrow=p)
beta_true[1:s]= 1:s
Y= X %*% beta_true + rnorm(n)


beta= matrix(rep(0,p), nrow=p)
beta_all= matrix(rep(0,p*L))
R= Y
ss= rep(0,p)
for(j in 1:p)
  ss[j]= sum(x[,j]^2) # simply x^2
err= rep(0,L)
for(l in 1:L){
  lambda= lambda_all[l]
  for(t in 1:T){
    for(j in 1:p){
      db= sum(R*x[,j])/ss[j]
      b= beta[j]+db
      b= sign(b)*max(0, abs(b)-lambda/ss[j])
      db= b-beta[j]
      R= R-X[,j]*db
      beta[j]= b
    }
  }
  beta_all[,l]= beta_all
  err[l]= sum((beta-beta_true)^2)
}

par(mfrow=c(1,2))
matplot(t(matrix(rep(1,p), nrow=1)) %*% abs(bata_all), abs(beta)m t*(beta_all), ..., type= 'l')
plot(lambda_all, err, type= 'l')