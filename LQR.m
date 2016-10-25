A = [1 1; 0 1];
B = [0 ; 1];
C = [1 0];

N = 20;

p_Q = 1;
p_R = 1;

Q_f = zeros(2)
Q = p_Q*eye(2) % should be C.' * Q * C?
R = p_R * eye(1)

x_0 = [1 ; 0];

% compute P, K matrices
P = cell(N+1,1);
K = cell(N,1);

P{N+1} = Q_f;

for i=1:N
    t = N-i+1;
    K{t} = inv(R + (B.')*P{t+1}*B) * (B.')*P{t+1}*A;
    P{t} = Q + (K{t}.')*R*K{t} + (A + B*K{t}).' * P{t+1} * (A + B*K{t}); 
end    

K{1}
P{1}

u = cell(N, 1);
x = cell(N+1,1); x{1} = x_0;
y = cell(N, 1);
J = cell(N, 1);

for t=2:N+1
   u{t-1} = -K{t-1} * x{t-1};
   x{t} = A*x{t-1} + B*u{t-1};
   y{t-1} = C*x{t-1};
   J{t-1} = x{t-1}.' * P{t-1} * x{t-1};
end