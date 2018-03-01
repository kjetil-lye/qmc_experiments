class RandomVariable(object):
    def __init__(self, X):
        self.X = X
        self.i = -1

    def __call__(self):
        # We do not want to get too high values, 
        # therefore we truncate a bit
        self.i += 1
        M = 1e4
        y = scipy.stats.norm.ppf(self.X[self.i])
        if y > M:
            return M
        elif y < -M:
            return -M
        return y

def variancefBm(H,n):
    return sqrt((1-2**(2*H-2))/(2**(2*n*H)))

def fBm(N, H, rand):
    n = log2(N)
    d = zeros((N+1,N+1))
    if N==1:
        return d
    else:
        dPrev = fBm(N//2,H,rand)
        
        for i in range(0,N//2):
            for j in range(0,N//2):
                d[2*i,2*j] = dPrev[i,j]
        
        
        for i in range(0,N//2,1):
            for j in range(0,N//2,1):
                iCenter = 2*i+1
                jCenter = 2*j
                
                
                iLeft  = 2*i
                iRight = 2*(i+1)
                
                d[iCenter, jCenter] = 0.5*(d[iLeft,2*j]+d[iRight,2*j])+variancefBm(H,n)*rand()
        
        
                iCenter = 2*i
                jCenter = 2*j+1
                
                
                jLeft  = 2*j
                jRight = 2*(j+1)
                
                d[iCenter, jCenter] = 0.5*(d[2*i,jLeft]+d[2*i,jRight])+variancefBm(H,n)*rand()
                
       
                iCenter = 2*i+1
                jCenter = 2*j+1
                
                
                jLeft  = 2*j
                jRight = 2*(j+1)
                
                iLeft = 2*i
                iRight = 2*(i+1)
                
                d[iCenter, jCenter] = 1.0/4.0*(d[iLeft,jLeft]+d[iLeft,jRight] \
                                              +d[iRight,jLeft]+d[iRight,jRight]) \
                                              +variancefBm(H,n)*rand()
        
        return d


# This is found in the paper
# Brouste, A., Istas, J., & Lambert-Lacroix, S. (2007).
#  On Fractional Gaussian Random Fields Simulations. Journal of Statistical Software, 23(1), 1–23.
#  http://doi.org/http://dx.doi.org/10.18637/jss.v023.i01
# in the section 2.3
def init_global(rho, ux, uy, p, nx, ny, nz):
    dux = fBm(nx, HURINDEX, RandomVariable(X[:nx*nx]))
    duy= fBm(nx, HURINDEX, RandomVariable(X[nx*nx:]))
    rho[:,:,0] = 4*ones_like(rho[:,:,0])
    ux[:,:,0] = dux[:-1,:-1]
    uy[:,:,0] = duy[:-1,:-1]
    p[:,:,0] = 2.5*ones_like(rho[:,:,0])



