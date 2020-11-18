A = [0.1 0; 0 0.5];
B = [1; 0.1];
C = [0, 1];
D = 1;
eps = 1e-6;

n = size(A, 1);
H = sdpvar(n);
gma = sdpvar(1);
solvesdp([[A'*H*A-H, A'*H*B, C'; B'*H*A, -gma+B'*H*B, D'; C, D, -gma]<0], gma,...
    sdpsettings('solver', 'sedumi', 'shift', eps));
disp(double(gma));
disp(double(H));