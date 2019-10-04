%Коновалова Петра Вариант 3

M = 5;
N = 3 * M;
eps = 1e-3;
lx = pi;
ly = 1;
hx = lx / N;
hy = ly / M;
hx2 = hx * hx;
hy2 = hy * hy;
d = (2*sin(pi*0.5/N)/hx)^2+(2*sin(pi*0.5/M)/hy)^2;
D = (2*cos(pi*0.5/N)/hx)^2+(2*cos(pi*0.5/M)/hy)^2;
xsi = d/D;
m = ceil(log(1/eps)*0.5/xsi);
ro = (1-xsi)/(1+xsi);

U_ex = U((0: N)' * hx, (0: M) * hy);
U_0 = zeros(N + 1, M + 1);
U_0(1: N + 1, 1) = U((0: N) * hx , 0);
U_0(1: N + 1, M + 1) = U((0: N) * hx, M * hy);
U_0(1, 2: M) = U(0, (1: M - 1) * hy);
U_0(N + 1, 2: M) = U(N  * hx, (1: M - 1) * hy);
fv = f((0:N)'*hx, (0:M)*hy);

fprintf("\n\n----------------------------------------Метод простой итерации----------------------------------------\n\n")
%1
fprintf("Мера аппроксимации: %e\n", Err(U_ex, fv, hx, hy));

%2
fprintf("Норма невязки нулевого приближения: %f\n", Err(U_0, fv, hx, hy));

%3
fprintf("Оцека количества итераций: %d\n", m);

%4
fprintf("Спектральный радиус матрицы перехода: %f\n", ro);

%5
fprintf("\n%5s %15s %15s %15s %15s %15s %15s %15s\n\n", "iter", "|F-AU^k|", ...
    "rel.d", "|U^k-U*|", "rel.err", "|U^k-U^(k-1)|", "apost.est", "rok");
U_sol = simpleIteration(U_0, U_ex, hx, hy, fv, m, ro);

%6
fprintf("\nПриближённое решение на крупной сетке\n");
sN = N / 5;
sM = M / 5;
for i = 1: sN: N + 1
    for j = 1: sM: M + 1
        fprintf("%15.7f", U_sol(i, j));
    end
    fprintf("\n");
end

%7
fprintf("\nТочное решение на крупной сетке\n");
for i= 1: sN: N + 1
    for j = 1: sM: M + 1
        fprintf("%15.7f", U_ex(i, j));
    end
    fprintf("\n");
end

m = ceil(log(1/eps)*0.25/xsi);

fprintf("\n\n----------------------------------------Метод Зейделя----------------------------------------\n\n")
%1
fprintf("Мера аппроксимации: %e\n", Err(U_ex, fv, hx, hy));

%2
fprintf("Норма невязки нулевого приближения: %f\n", Err(U_0, fv, hx, hy));

%3
fprintf("Оцека количества итераций: %d\n", m);

%4
fprintf("Спектральный радиус матрицы перехода: %f\n", ro);

%5
fprintf("\n%5s %15s %15s %15s %15s %15s %15s %15s\n\n", "iter", "|F-AU^k|", ...
    "rel.d", "|U^k-U*|", "rel.err", "|U^k-U^(k-1)|", "apost.est", "rok");
U_sol = Seidel(U_0, U_ex, hx, hy, fv, m, ro);

%6
fprintf("\nПриближённое решение на крупной сетке\n");
sN = N / 5;
sM = M / 5;
for i = 1: sN: N + 1
    for j = 1: sM: M + 1
        fprintf("%15.7f", U_sol(i, j));
    end
    fprintf("\n");
end

%7
fprintf("\nТочное решение на крупной сетке\n");
for i= 1: sN: N + 1
    for j = 1: sM: M + 1
        fprintf("%15.7f", U_ex(i, j));
    end
    fprintf("\n");
end

m = ceil(log(2/eps)/(2*sqrt(xsi)));

fprintf("\n\n----------------------------------------Итерационный метод с Чебышевским набором параметров----------------------------------------\n\n")
%1
fprintf("Мера аппроксимации: %e\n", Err(U_ex, fv, hx, hy));

%2
fprintf("Норма невязки нулевого приближения: %f\n", Err(U_0, fv, hx, hy));

%3
fprintf("Оцека количества итераций: %d\n", m);

%4
fprintf("Спектральный радиус матрицы перехода: %f\n", ro);

%5
fprintf("\n%5s %15s %15s %15s %15s %15s\n\n", "iter", "|F-AU^k|", ...
    "rel.d", "|U^k-U*|", "rel.err", "|U^k-U^(k-1)|");
U_sol = Chebyshev(U_0, U_ex, hx, hy, fv, m, D, d);

%6
fprintf("\nПриближённое решение на крупной сетке\n");
sN = N / 5;
sM = M / 5;
for i = 1: sN: N + 1
    for j = 1: sM: M + 1
        fprintf("%15.7f", U_sol(i, j));
    end
    fprintf("\n");
end

%7
fprintf("\nТочное решение на крупной сетке\n");
for i= 1: sN: N + 1
    for j = 1: sM: M + 1
        fprintf("%15.7f", U_ex(i, j));
    end
    fprintf("\n");
end
