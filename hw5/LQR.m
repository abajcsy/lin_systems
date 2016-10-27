A = [1 1; 0 1];
B = [0 ; 1];
C = [1 0];

N = 20;

p_Q = 1;
p_R = 10*10*10;

Q = C.' * p_Q*[1] * C;
R = p_R * [1];

x_0 = [1 ; 0];

% compute P, K matrices
P = cell(N+1,1);
K = cell(N,1);
P{N+1} = Q;

for i=1:N
    t = N-i+1;
    K{t} = inv(R + (B.')*P{t+1}*B) * (B.')*P{t+1}*A;
    P{t} = Q + (K{t}.')*R*K{t} + (A - B*K{t}).' * P{t+1} * (A - B*K{t}); 
end    

u = zeros(1,N);
x = cell(N+1,1); x{1} = x_0;
y = zeros(1,N);
J = zeros(1,N);

for t=2:N+1
   u(t-1) = -K{t-1} * x{t-1};
   x{t} = A*x{t-1} + B*u(t-1);
   y(t-1) = C*x{t-1};
   J(t-1) = x{t-1}.' * P{t-1} * x{t-1};
end

T = [1:N];
hold on
plot(T, u, 'LineWidth',2)
plot(T, y, 'LineWidth',2)
plot(T, J, 'LineWidth',2)
title('Control, Output, and Cost-to-go for p_Q = 1, p_R = 10^3')
legend('control','output', 'cost-to-go')

m = [0; 1]
n = [2 3]
m*n

syms b
bla = [0 1; -b.^(-1/2) -sqrt(2)*b.^(-1/4)]
[V,D] = eig(bla)