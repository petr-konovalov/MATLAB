A = [1 0; 0 1];
R = 1;
B = [0; 0];
G = [1 0; 0 1];
Q = [-3 2; 2 -3];

res = solve(A, Q, R, G, B);
yalmip('clear');
disp(res);
