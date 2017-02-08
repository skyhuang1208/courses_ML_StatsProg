def eign_qr(A):
    T= 1000
    A_copy= A.copy()
    r, c= A_copy.shape
    v= np.random.random_sample((1,r))
    for i in range(T):
        Q, Sth = qr(v)
        v= np.dot(A_copy, Q)
    Q, R= qr(v)
    return R.diagonal(), Q

# PCA
n= 100
p= 5
X= np.random.random_sample((n,p))
A= np.dot(X.T, X)
P, v= eign_qr(A)
print P, v
