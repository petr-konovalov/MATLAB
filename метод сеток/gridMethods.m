% format short;
% 
% N = 7;
% M = 7;
% T = 0.1;
% 
% usol = gridMethodDiff(@(x, t)(3 * t ^ 2 - 3 * x ^ 4 - 3 * x ^ 2 - 6 * x), @(x)(x ^ 3), @(t)(0), @(t)(3), N, M, T);  
% disp(usol);
% 
% u = zeros(M + 1, N + 1);
% for k = 1: M + 1
%     for j = 1: N + 1
%         u(k, j) = (0.1 * (k - 1) / M) ^ 3 + ((j - 1) / N) ^ 3;
%     end
% end
% 
% disp(u);
syms x t;
T = 0.1;

N0 = 10;
M0 = 20;
u0 = 1;
%dispPhiAlpBetF(u0, x, t);
phi0 = @(x)(1);
alp0 = @(t)(0);
bet0 = @(t)(0);
f0 = @(x, t)(0);

N1 = 10;
M1 = 40;
u1 = x ^ 3 + t ^ 3;
%dispPhiAlpBetF(u1, x, t);
phi1 = @(x)(x^3);
alp1 = @(t)(0);
bet1 = @(t)(3);
f1 = @(x, t)(3 * t ^ 2 - 3 * x ^ 2 * (x ^ 2 + 1) - 6 * x);

N2 = 10;
M2 = 40;
u2 = sin(2 * t + 1) * cos(2 * x);
%dispPhiAlpBetF(u2, x, t);
phi2 = @(x)(cos(2 * x) * sin(1));
alp2 = @(t)(0);
bet2 = @(t)(-2 * sin(2) * sin(2 * t + 1));
f2 = @(x, t)(2 * cos(2 * x) * cos(2 * t + 1) + 4 * cos(2 * x) * sin(2 * t + 1) + 2 * sin(2 * x) * sin(2 * t + 1) * (x ^ 2 + 1));

printExSolveTable(u0, x, t);
printSolveTableFast(f0, phi0, alp0, bet0, N0, M0, T, @(f, phi, alp, bet, N, M, T)(paramGridMethodDiff(f, phi, alp, bet, N, M, T, 1)));
printSolveTableFast(f0, phi0, alp0, bet0, N0, M0, T, @gridMethodDiff);

printExSolveTable(u1, x, t);
printSolveTableFast(f1, phi1, alp1, bet1, N1, M1, T, @(f, phi, alp, bet, N, M, T)(paramGridMethodDiff(f, phi, alp, bet, N, M, T, 1)));
printSolveTableFast(f1, phi1, alp1, bet1, N1, M1, T, @gridMethodDiff);

% printExSolveTable(u, x, t);
% 
% printSolveTable(u, x, t, N, M, T, @gridMethodDiff);
% printSolveTable(u, x, t, N, M, T, @(f, phi, alp, bet, N, M, T)(paramGridMethodDiff(f, phi, alp, bet, N, M, T, 1)));