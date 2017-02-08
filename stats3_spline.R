# Generate data (hypothesis data)
x= runif(n)
x= sort(x)
y= x^2+rnorm(n)*sigma
X= matrix(x, nrow=n)

# Do the fitting
for(k in 1:(p-1)/p) # 1:(p-1)/p means 1:(p-1) and then values divided by p
  X= cbind(x, (x>k)*(x-k)) # max(0, x-kj)
beta= Ridge(X, Y, lambda)
yhat= cbind(rep(1,n), x) %&% beta

# Plot data
plot(x, y, ylim(1-.2, 1.2), col='red')
par(new=TRUE)
plot(x, yhat, ylim= ..., type='d', col='green')