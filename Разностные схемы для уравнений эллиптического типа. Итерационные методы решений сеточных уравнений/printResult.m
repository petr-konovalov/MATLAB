function printResult(method, N, M, U_0, U_ex, hx, hy, fv, m, ro, v1, v2, v3)
    printMethodName(method);
    fprintf("Мера аппроксимации: %e\n", Err(U_ex, fv, hx, hy));
    fprintf("Норма невязки нулевого приближения: %f\n", Err(U_0, fv, hx, hy));
    fprintf("Оцека количества итераций: %d\n", m);
    fprintf("Спектральный радиус матрицы перехода: %f\n", ro);
    printIterTableColName(method);
    switch nargin - 10
        case 0
            U_sol = getSolution(method, U_0, U_ex, hx, hy, fv, m, ro);
        case 2
            U_sol = getSolution(method, U_0, U_ex, hx, hy, fv, m, ro, v1, v2);
        case 3
            U_sol = getSolution(method, U_0, U_ex, hx, hy, fv, m, ro, v1, v2, v3);
    end
    fprintf("\nПриближённое решение на крупной сетке\n");
    printSolution(U_sol, N, M);
    fprintf("\nТочное решение на крупной сетке\n");
    printSolution(U_ex, N, M);
end

function sol = getSolution(method, U_0, U_ex, hx, hy, fv, m, ro, v1, v2, v3)
    if method == "simpleIteration"
        sol = simpleIteration(U_0, U_ex, hx, hy, fv, m, ro);
    elseif method == "Seidel"
        sol = Seidel(U_0, U_ex, hx, hy, fv, m, ro);
    elseif method == "Chebyshev"
        sol = Chebyshev(U_0, U_ex, hx, hy, fv, m, v1, v2);
    elseif method == "altTriangularMethod"
        sol = altTriangularMethod(U_0, U_ex, hx, hy, fv, m, v1, v2, v3);
    end
end

function printMethodName(method)
    if method == "simpleIteration"
        fprintf("\n\n----------------------------------------Метод простой итерации----------------------------------------\n\n");
    elseif method == "Seidel"
        fprintf("\n\n----------------------------------------Метод Зейделя----------------------------------------\n\n");
    elseif method == "Chebyshev"
        fprintf("\n\n----------------------------------------Итерационный метод с Чебышевским набором параметров----------------------------------------\n\n");
    elseif method == "altTriangularMethod"
        fprintf("\n\n----------------------------------------Попеременно-треугольный итерационный метод----------------------------------------\n\n");
    end
end

function printIterTableColName(method)
    if method == "simpleIteration" || method == "Seidel"
        fprintf("\n%5s %15s %15s %15s %15s %15s %15s %15s\n\n", "iter", "|F-AU^k|", ...
            "rel.d", "|U^k-U*|", "rel.err", "|U^k-U^(k-1)|", "apost.est", "rok");
    elseif method == "Chebyshev" || method == "altTriangularMethod"
        fprintf("\n%5s %15s %15s %15s %15s %15s\n\n", "iter", "|F-AU^k|", ...
            "rel.d", "|U^k-U*|", "rel.err", "|U^k-U^(k-1)|");
    end
end
