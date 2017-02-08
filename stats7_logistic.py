def mylogistic(_x, _y):
    x= _x.copy()
    y= _y.copy()
    r, c= x.shape
    beta= np.zeros((c, 1))
    epsilon= 1e-6

    while True:
        eta= np.dot(x, beta)
        pr= exp_it(eta)
        w= pr * (1-pr)
        z= eta+(y-pr)/w
        sw= np.sqrt(w)
        mw= np.repeat(sw, c, axis=1)
        x_work= mw * x
        y_work= sw * z
        
        beta+new, ---, ---, --- = np.linalg.lstsq(x_work, y_work)
        err= np.sum(np.abs(beta_new_beta))
        beta= beta_new
        if err < epsilon:
            break

    return beta
