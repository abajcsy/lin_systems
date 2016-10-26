A = [0 1; 0 0];
B = [0; 1];
C = [1 0];

Q = [1];
R = 1;

% solve Continuous-time algebraic Riccati equation solution
[X,L,G] = care(A,B,C'*C,R)

% optimal gain matrix K, the Riccati solution S, and the closed-loop eigenvalues e = eig(A-B*K)
sys = ss(A,B,C,0) 
[K,S,e] = lqry(sys,Q,R) 

F = R^(-1)*B.'*S

