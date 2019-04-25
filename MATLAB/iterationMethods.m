function iterationMethods()
    clc;
    format long;
    eps = 0.001;
    
    [~, matr] = getSystem('inp.txt');
    A = matr(1: size(matr, 1), 1: size(matr, 1));
    b = matr(1: size(matr, 1), size(matr, 2): size(matr, 2));
    [gaussAns, ~] = solveChoice(matr);
    
    disp('Исходная система:');
    disp(matr);
    
    disp('Гаусс:');
    disp(gaussAns);
    
    [HD, gD] = getHg(A, b);
    disp('HD:');
    disp(HD);
    disp('gD:');
    disp(gD);
    
    disp('Норма HD:');
    nHD = norma(HD);
    ngD = norma(gD);
    disp(nHD);
    disp('Спектральный радиус HD:');
    disp(matrRadius(HD));
    disp(eig(HD));
    
    disp('--------Метод простой итерации--------');
    disp('Оценка числа итераций:');
    k = ceil(log((1 - nHD) / ngD * eps) / log(nHD));
    disp(k);
    
    [iterationAns, itCnt, prev] = simpleIteration(HD, gD, nHD, eps);
    disp('Фактическое число итераций:');
    disp(itCnt);
    disp('Результат:');
    disp(iterationAns);
    disp('Фактическа погрешность:');
    disp(norma(iterationAns - gaussAns));
    disp('Апостериорная оценка:');
    disp(norma(iterationAns - prev) * (nHD) / (1 - nHD));
    disp('Априорная оценка:');
    disp((nHD ^ itCnt) * ngD / (1 - nHD));
    
    LusternikImprove = prev + (iterationAns - prev) / (1 - matrRadius(HD));
    disp('Улучшение по Люстернику:');
    disp(LusternikImprove);
    disp('Погрешность:');
    disp(norma(LusternikImprove - gaussAns));
    
    [ZeidelAns, itCnt] = ZeidelMethod(HD, gD, nHD, eps);
    disp('--------Метод Зейделя--------');
    disp('Результат:');
    disp(ZeidelAns);
    disp('Количество итераций:');
    disp(itCnt);
    disp('Погрешность:');
    disp(norma(ZeidelAns - gaussAns));
    disp('Спектральный радиус матрицы перехода:');
    disp(getZeidelRadius(HD));
    
    [upperIterationAns, itCnt] = upperIterationMethod(HD, gD, nHD, eps);
    disp('--------Метод верхней релаксации--------');
    disp(upperIterationAns);
    disp('Количество итераций:');
    disp(itCnt);
    disp('Погрешность:');
    disp(norma(upperIterationAns - gaussAns));
end

function [res, itCnt, prev] = simpleIteration(HD, gD, nHD, eps)
    itCnt = 1;
    prev = zeros(size(gD));
    res = gD;
    e = eps * (1 - nHD) / nHD;
    while norma(res - prev) >= e
       prev = res;
       res = HD * res + gD;
       itCnt = itCnt + 1;
    end
end

function [res, itCnt] = ZeidelMethod(H, g, nH, eps)
    itCnt = 1;
    prev = zeros(size(g));
    res = getNextZeidelApproximation(H, g, prev);
    e = eps * (1 - nH) / nH;
    while norma(res - prev) >= e
        prev = res;
        res = getNextZeidelApproximation(H, g, res);
        itCnt = itCnt + 1;
    end
end

function [res] = getNextZeidelApproximation(H, g, cur)
    res = zeros(size(cur));
    for i = 1: size(res)
        res(i) = g(i);
        for j = 1: i - 1
            res(i) = res(i) + H(i, j) * res(j);
        end
        for j = i: size(res)
            res(i) = res(i) + H(i, j) * cur(j);
        end
    end
end

function [R] = getZeidelRadius(H)
    HL = zeros(size(H, 1), size(H, 2));
    HR = zeros(size(H, 1), size(H, 2));
    
    for i = 1: size(H, 1)
        for j = 1: size(H, 2)
            if j < i
                HL(i, j) = H(i, j);
            else
                HR(i, j) = H(i, j);
            end
        end
    end
    
    R = matrRadius((eye(size(H, 1)) - HL) \ HR);
end


function [res, itCnt] = upperIterationMethod(H, g, nH, eps)
    itCnt = 1;
    q = 2 / (1 + sqrt(1 - matrRadius(H) ^ 2));
    prev = zeros(size(g));
    res = getUpperIterationNextApproximation(H, g, q, prev);
    e = eps * (1 - nH) / nH;
    while norma(res - prev) >= e
        prev = res;
        res = getUpperIterationNextApproximation(H, g, q, res);
        itCnt = itCnt + 1;
    end
end

function [res] = getUpperIterationNextApproximation(H, g, q, cur)
    res = cur;
    for i = 1: size(res)
        add = -cur(i) + g(i);
        for j = 1: i - 1
            add = add + H(i, j) * res(j);
        end
        for j = i + 1: size(res)
            add = add + H(i, j) * cur(j);
        end
        res(i) = res(i) + q * add;
    end
end

function [HD, gD] = getHg(A, b)
    HD = zeros(size(A, 1), size(A, 2));
    gD = zeros(size(b));
    
    for i = 1: size(A, 1)
        for j = 1: size(A, 2)
            if i ~= j
                HD(i, j) = -A(i, j) / A(i, i);
            end
        end
    end
    
    for i = 1: size(b)
        gD(i) = b(i) / A(i, i);
    end
end

function [res] = norma(matr)
    res = 0;
    for i = 1: size(matr, 1)
        sum = 0;
        for j = 1: size(matr, 2)
            sum = sum + abs(matr(i, j));
        end
        res = max(res, sum);
    end
end

function [R] = matrRadius(matr)
    v = eig(matr);
    R = 0;
    for i = 1: size(v)
        R = max(R, abs(v(i)));
    end
end

