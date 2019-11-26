%Коновалова Петра Вариант 3

MSet = [5 10 20];
NSet = 3 * MSet;
global ItRes;
global State;
global eps;
ItRes = zeros(5, size(MSet, 2));

for j = 1: size(MSet, 2)
    State = j;
    M = MSet(j);
    N = NSet(j);
    fprintf('\n\n%d %d', M, N);
    eps = 1e-3;
    lx = pi;
    ly = 1;
    hx = lx / N;
    hy = ly / M;
    hx2 = hx * hx;
    hy2 = hy * hy;

    U_ex = mU((0: N)' * hx, (0: M) * hy);
    U_0 = zeros(N + 1, M + 1);
    U_0(1: N + 1, 1) = mU((0: N) * hx , 0);
    U_0(1: N + 1, M + 1) = mU((0: N) * hx, M * hy);
    U_0(1, 2: M) = mU(0, (1: M - 1) * hy);
    U_0(N + 1, 2: M) = mU(N  * hx, (1: M - 1) * hy);
    fv = f((0:N)'*hx, (0:M)*hy);

    d = (2*sin(pi*0.5/N)/hx)^2+(2*sin(pi*0.5/M)/hy)^2;
    D = (2*cos(pi*0.5/N)/hx)^2+(2*cos(pi*0.5/M)/hy)^2;
    xsi = d/D;
    m = ceil(log(1/eps)*0.5/xsi);
    ro = (1-xsi)/(1+xsi);
    printResult("simpleIteration", N, M, U_0, U_ex, hx, hy, fv, m, ro);

    m = ceil(log(1/eps)*0.25/xsi);
    printResult("Seidel", N, M, U_0, U_ex, hx, hy, fv, m, ro * ro);

    m = ceil(log(2/eps)/(2*sqrt(xsi)));
    printResult("Chebyshev", N, M, U_0, U_ex, hx, hy, fv, m, ro, D, d);

    D = 4 / hx2 + 4 / hy2;
    eta = d / D;
    omga = 2 / sqrt(d * D);
    gma1 = d / (2 + 2 * sqrt(eta));
    gma2 = d / (4 * sqrt(eta));
    tau = 2 / (gma1 + gma2);
    k1 = omga / (hx * hx);
    k2 = omga / (hy * hy);
    xsi = gma1 / gma2;
    ro = (1 - xsi) / (1 + xsi);
    m = ceil(log(eps) / log(ro)) + 2;
    printResult("altTriangularMethod", N, M, U_0, U_ex, hx, hy, fv, m, ro, k1, k2, tau);

    fprintf('\n\n----------------------------------------Схема переменных направлений----------------------------------------\n\n');

    fprintf("Мера аппроксимации: %e\n", Err(U_ex, fv, hx, hy));
    fprintf("Норма невязки нулевого приближения: %f\n", Err(U_0, fv, hx, hy));

    d = min(4/(hx*hx)*sin(pi/(2*N))^2, 4/(hy*hy)*sin(pi/(2*M))^2);
    D = max(4/(hx*hx)*cos(pi/(2*N))^2, 4/(hy*hy)*cos(pi/(2*M))^2);
    tau = 2 / sqrt(d * D);
    m = ceil(max(N, M) / (2 * pi) * log(1 / eps));

    fprintf("\n%5s %15s %15s %15s %15s %15s\n\n", "iter", "|/\U^k+F|", ...
                "rel.d", "|U^k-U*|", "rel.err", "|U^k-U^(k-1)|");
    U_sol = diffDirectScheme(U_0, U_ex, N, M, hx, hy, fv, m, tau);
    fprintf("\nПриближённое решение на крупной сетке\n");
    printSolution(U_sol, N, M);
    fprintf("\nТочное решение на крупной сетке\n");
    printSolution(U_ex, N, M);
end
%disp(ItRes);
fprintf('\n\n');
fprintf('%60s%7s%7s%30s\n\n', 'Название метода', 'N', 'M', 'Количество итераций')

fprintf('%60s%7d%7d%30d\n', 'Метод простой итерации', NSet(1), MSet(1), ItRes(1, 1));
fprintf('%60s%7d%7d%30d\n',                       '', NSet(2), MSet(2), ItRes(1, 2));
fprintf('%60s%7d%7d%30d\n\n',                       '', NSet(3), MSet(3), ItRes(1, 3));

fprintf('%60s%7d%7d%30d\n', 'Метод Зейделя', NSet(1), MSet(1), ItRes(2, 1));
fprintf('%60s%7d%7d%30d\n',              '', NSet(2), MSet(2), ItRes(2, 2));
fprintf('%60s%7d%7d%30d\n\n',              '', NSet(3), MSet(3), ItRes(2, 3));

fprintf('%60s%7d%7d%30d\n', 'Итерационный метод с Чебышёвским набором параметров', NSet(1), MSet(1), ItRes(3, 1));
fprintf('%60s%7d%7d%30d\n',                                                    '', NSet(2), MSet(2), ItRes(3, 2));
fprintf('%60s%7d%7d%30d\n\n',                                                    '', NSet(3), MSet(3), ItRes(3, 3));

fprintf('%60s%7d%7d%30d\n', 'Попеременно треугольный итерационный метод', NSet(1), MSet(1), ItRes(4, 1));
fprintf('%60s%7d%7d%30d\n',                       '', NSet(2), MSet(2), ItRes(4, 2));
fprintf('%60s%7d%7d%30d\n\n',                       '', NSet(3), MSet(3), ItRes(4, 3));

fprintf('%60s%7d%7d%30d\n', 'Схема переменных направлений', NSet(1), MSet(1), ItRes(5, 1));
fprintf('%60s%7d%7d%30d\n',                       '', NSet(2), MSet(2), ItRes(5, 2));
fprintf('%60s%7d%7d%30d\n',                       '', NSet(3), MSet(3), ItRes(5, 3));