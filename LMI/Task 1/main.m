A = [1 0; 0 1];
R = 1;
B = [0; 0];
G = [1 0; 0 1];
Q = [-3 2; 2 -3];

[opt, res] = solve(A, Q, R, G, B);
disp(opt);
disp(res);
