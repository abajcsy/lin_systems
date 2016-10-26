global A;
global B;
global K; 

A = [0 1; 0 0];
B = [0; 1];

Q = [100 0; 0 1];
R = 1;

% solve Riccati equation solution
[K,P,E] = lqr(A,B,Q,R)

x0 = [10 10];
t0 = 0; tf = 20;
[T,x] = ode23('xdot', [t0,tf], x0)

plot(T, x(:,1), T, x(:,2), '--', 'LineWidth',2)
title('State and velocity over time with Q = [1 0; 0 1], R = 1')
legend('state','velocity')