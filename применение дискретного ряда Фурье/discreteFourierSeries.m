uf = getExSol(10);

disp("Точное решение");
disp(uf);

disp("Максимальное отклонение от точного решения дискретного метода Фурье в узлах крупной сетки при различных значениях N");
for N = [5, 10, 20]
    fprintf("N = %3d    %e\n", N, max(max(abs(uf - getDescreteSol(N)))));
end

H = [0.2 0.1 0.05 0.05];
Tau = [0.02 0.005 0.00125 0.005];

Ans = zeros(4, 4);
for i = 1: 4
    N = round(1 / H(i));
    M = round(0.1 / Tau(i));
    Sgm = [0, 1, 0.5, 0.5 - H(i)^2/(12*Tau(i))];
    
    for j = 1: 4
        Ans(i, j) = max(max(abs(uf - getWeightDescSol(N, M, Sgm(j)))));
    end
end


fprintf("\nТаблица отклонений схемы с весами при различных значениях параметра\n");
for i = 1: 4
    for j = 1: 4
        fprintf("%e ", Ans(j, i));
    end
    fprintf("\n");
end