syms x t;
T = 0.1;

u0 = 1;
%dispPhiAlpBetF(u0, x, t);
phi0 = @(x)(1);
alp0 = @(t)(0);
bet0 = @(t)(0);
f0 = @(x, t)(0);

u1 = x ^ 3 + t ^ 3;
%dispPhiAlpBetF(u1, x, t);
phi1 = @(x)(x^3);
alp1 = @(t)(0);
bet1 = @(t)(3);
f1 = @(x, t)(3 * t ^ 2 - 3 * x ^ 2 * (x ^ 2 + 1) - 6 * x);

u2 = sin(2 * t + 1) * cos(2 * x);
%dispPhiAlpBetF(u2, x, t);
phi2 = @(x)(cos(2 * x) * sin(1));
alp2 = @(t)(0);
bet2 = @(t)(-2 * sin(2) * sin(2 * t + 1));
f2 = @(x, t)(2 * cos(2 * x) * cos(2 * t + 1) + 4 * cos(2 * x) * sin(2 * t + 1) + 2 * sin(2 * x) * sin(2 * t + 1) * (x ^ 2 + 1));

disp("Функция решения:");
disp(u0);
disp("Таблица точных значений:");
exSol = getExSolveTable(u0, x, t);

disp("------------------------------------------------------------------------------------------------------------------------------------------------------------");
disp("Явная схема с аппроксимацией в граничных условиях с квадратичной точностью");
disp("N = 5 M = 10 M1 = 10");
printGridMethodRes(exSol, f0, phi0, alp0, bet0, 5, 10, 10, T, @gridMethodDiff)
disp("Хуже не станет, поэтому для остальных значений N можно не выводить");

disp("------------------------------------------------------------------------------------------------------------------------------------------------------------");
disp("Явная схема с аппроксимацией в граничных условиях с точностью первой степени");
disp("N = 5 M = 10 M1 = 10");
printGridMethodRes(exSol, f0, phi0, alp0, bet0, 5, 10, 10, T, @param0GridMethodDiff)
disp("Хуже не станет, поэтому для остальных значений N можно не выводить");

disp("------------------------------------------------------------------------------------------------------------------------------------------------------------");
disp("Неявные схемы с аппроксимацией в граничных условиях с точностью первой степени");
disp("Sigma = 1");
for M = [10, 100]
    for N = [5, 10, 20]
        fprintf("N = %d M = %d\n", N, M);
        printGridMethodRes(exSol, f0, phi0, alp0, bet0, N, M, M, T, @(f, phi, alp, bet, N, M, T)(paramGridMethodDiff(f, phi, alp, bet, N, M, T, 1)));
    end
end

disp("Sigma = 1/2");
for M = [10, 100]
    for N = [5, 10, 20]
        fprintf("N = %d M = %d\n", N, M);
        printGridMethodRes(exSol, f0, phi0, alp0, bet0, N, M, M, T, @(f, phi, alp, bet, N, M, T)(paramGridMethodDiff(f, phi, alp, bet, N, M, T, 0.5)));
    end
end

disp("Функция решения:");
disp(u1);
disp("Таблица точных значений:");
exSol = getExSolveTable(u1, x, t);
disp(exSol);

disp("------------------------------------------------------------------------------------------------------------------------------------------------------------");
disp("Явная схема с аппроксимацией в граничных условиях с квадратичной точностью");
N = [5 10 20];
M = [5 5 80];
M1 = [5 80 320];

for j = 1: 3
    fprintf("N = %d M = %d M1 = %d\n", N(j), M(j), M1(j));
    printGridMethodRes(exSol, f1, phi1, alp1, bet1, N(j), M(j), M1(j), T, @gridMethodDiff)
end

disp("------------------------------------------------------------------------------------------------------------------------------------------------------------");
disp("Явная схема с аппроксимацией в граничных условиях с точностью первой степени");
N = [5 10 20];
M = [10 20 80];
M1 = [20 80 320];

for j = 1: 3
    fprintf("N = %d M = %d M1 = %d\n", N(j), M(j), M1(j));
    printGridMethodRes(exSol, f1, phi1, alp1, bet1, N(j), M(j), M1(j), T, @param0GridMethodDiff)
end

disp("------------------------------------------------------------------------------------------------------------------------------------------------------------");
disp("Неявные схемы с аппроксимацией в граничных условиях с точностью первой степени");
disp("Sigma = 1");
for M = [10, 100]
    for N = [5, 10, 20]
        fprintf("N = %d M = %d\n", N, M);
        printGridMethodRes(exSol, f1, phi1, alp1, bet1, N, M, M, T, @(f, phi, alp, bet, N, M, T)(paramGridMethodDiff(f, phi, alp, bet, N, M, T, 1)));
    end
end

disp("Sigma = 1/2");
for M = [10, 100]
    for N = [5, 10, 20]
        fprintf("N = %d M = %d\n", N, M);
        printGridMethodRes(exSol, f1, phi1, alp1, bet1, N, M, M, T, @(f, phi, alp, bet, N, M, T)(paramGridMethodDiff(f, phi, alp, bet, N, M, T, 0.5)));
    end
end

%старый способ вывода можно использовать для проверки работоспособности

% printExSolveTable(u0, x, t);
% printSolveTableFast(f0, phi0, alp0, bet0, N0, M0, T, @(f, phi, alp, bet, N, M, T)(paramGridMethodDiff(f, phi, alp, bet, N, M, T, 1)));
% printSolveTableFast(f0, phi0, alp0, bet0, N0, M0, T, @gridMethodDiff);
% printSolveTableFast(f0, phi0, alp0, bet0, N0, M0, T, @param0GridMethodDiff);
% 
% printExSolveTable(u1, x, t);
% printSolveTableFast(f1, phi1, alp1, bet1, N1, M1, T, @(f, phi, alp, bet, N, M, T)(paramGridMethodDiff(f, phi, alp, bet, N, M, T, 1)));
% printSolveTableFast(f1, phi1, alp1, bet1, N1, M1, T, @gridMethodDiff);
% printSolveTableFast(f1, phi1, alp2, bet1, N1, M1, T, @param0GridMethodDiff);

% printExSolveTable(u, x, t);
% 
% printSolveTable(u, x, t, N, M, T, @gridMethodDiff);
% printSolveTable(u, x, t, N, M, T, @(f, phi, alp, bet, N, M, T)(paramGridMethodDiff(f, phi, alp, bet, N, M, T, 1)));