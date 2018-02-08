w  = [0.547160757260330, 1.758164169633519, 3.243987484932942, 4.781982505508050, 6.335748362345733, 7.896171137138582, 9.459999472511342, 11.025797211953535, 12.592834514443268, 14.160701917675429]
eta    = 3.0;
sigmaY = 1.0;
KL_MAX = 10
def calc_lambda (m):
    return 2 * eta * sigmaY**2 / (eta**2 * w[m]**2 + 1)



def calc_Phi ( m,  u):
    return ( eta * w[m] * cos(w[m] * u) + sin(w[m] * u) ) / sqrt( ((eta)**2 * (w[m])**2 + 1) * 1./2 + eta )



def calc_dPhi ( m,  u):
    return ( - eta * w[m] * w[m] * sin(w[m] * u) + w[m] * cos(w[m] * u) ) / sqrt( ((eta)**2 * (w[m])**2 + 1) * 1./2 + eta )



def calc_KL ( x, X):
    value = 0
    for  m in range(1, KL_MAX):
        value += 0.2 * sqrt( calc_lambda(m) ) * calc_Phi(m,x) * X [m-1];
    return value




u = calc_KL(x, X)
