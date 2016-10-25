import numpy as np
from numpy import *
import scipy.linalg
from numpy.linalg import inv
import matplotlib.pyplot as plt

def dlqr(A,B,Q,R):
    """Solve the discrete time lqr controller.
     
    x[k+1] = A x[k] + B u[k]
     
    cost = sum x[k].T*Q*x[k] + u[k].T*R*u[k]
    """
    #ref Bertsekas, p.151
 
    #first, try to solve the ricatti equation
    X = np.matrix(scipy.linalg.solve_discrete_are(A, B, Q, R))
     
    #compute the LQR gain
    K = np.matrix(inv(R + B.T*X*B)*(B.T*X*A))
     
    eigVals, eigVecs = scipy.linalg.eig(A-B*K)
     
    return K, X, eigVals

def compute_PK(A, B, Q, R, N):
	P = [None] * (N+1)
	K = [None] * N

	P[N] = Q

	#for t in range(N-1,-1,-1):

	#K[t] = inv(R + (B.T)*P[t+1]*B)*(B.T)*P[t+1]*A
	#P[t] = Q + (K[t].T)*R*K[t] + ((A + B*K[t]).T)*P[t+1]*(A + B*K[t])

	for i in range(0,N):
		t = N-i-1
		K[t] = inv(R + (B.T)*P[t+1]*B) * (B.T) * P[t+1] * A
		P[t] = Q + (K[t].T)*R*K[t] + ((A + B*K[t]).T)*P[t+1]*(A + B*K[t])

	return (P,K)

if __name__ == '__main__':
	A = np.matrix("1 0; 0 1")
	B = np.matrix("0;1")
	C = np.matrix("1 0")

	N = 20

	p_Q = 1
	p_R = 10*10*10

	Q = p_Q*np.matrix("1 0; 0 1")
	R = p_R*np.matrix("1 0; 0 1")
	print R

	x_0 = np.matrix("1;0")

	(P,K) = compute_PK(A, B, Q, R, N)
	print K[0]

	u = [None] * N
	x = [None] * (N+1); x[0] = x_0 
	y = [None] * N
	J = [None] * N

	for t in range(1,N+1):
		u[t-1] = -K[t-1]*x[t-1]
		x[t] = A*x[t-1] + B*u[t-1]
		y[t-1] = C*x[t-1]
		J[t-1] = x[t-1].T * P[t-1] * x[t-1]

	print "x[t]: ", x, "\n"
	print "u[t]: ", u, "\n"
	print "y[t]: ", y, "\n"
	print "control (K): ", K
	print "cost-to-go (J): ", J

	
		
