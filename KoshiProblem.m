function KoshiProblem(A, initY)
    clc;
    format long;
    
    printTable(A, initY, 2);
    printTable(A, initY, 100);
end

function printTable(A, initY, cnt)
    h = 0.1 / cnt;
    points = [0 0.1 0.2 0.3 0.4 0.5];
    
    exactSolution = getExactSolution(A, initY, points);
    explicitEilerSol = explicitEiler(A, initY, h, cnt * 5);
    implicitEilerSol = implicitEiler(A, initY, h, cnt * 5);
    AdamsInterpolation2OrdSol = AdamsInterpolation2Ord(A, initY, h, cnt * 5);
    AdamsInterpolation3OrdSol = AdamsInterpolation3Ord(A, initY, h, cnt * 5);
    AdamsExtarpolation2OrdSol = AdamsExtarpolation2Ord(A, initY, h, cnt * 5);
    
    dat = zeros(6, numel(points));
    for k = 0: numel(points) - 1
        dat(1, k + 1) = exactSolution(k + 1, 1);
        dat(2, k + 1) = exactSolution(k + 1, 2);
        dat(3, k + 1) = explicitEilerSol(1 + k * cnt, 1) - dat(1, k + 1);
        dat(4, k + 1) = explicitEilerSol(1 + k * cnt, 2) - dat(2, k + 1);
        dat(5, k + 1) = implicitEilerSol(1 + k * cnt, 1) - dat(1, k + 1);
        dat(6, k + 1) = implicitEilerSol(1 + k * cnt, 2) - dat(2, k + 1);
        dat(7, k + 1) = AdamsInterpolation2OrdSol(1 + k * cnt, 1) - dat(1, k + 1);
        dat(8, k + 1) = AdamsInterpolation2OrdSol(1 + k * cnt, 2) - dat(2, k + 1);
        dat(9, k + 1) = AdamsInterpolation3OrdSol(1 + k * cnt, 1) - dat(1, k + 1);
        dat(10,k + 1) = AdamsInterpolation3OrdSol(1 + k * cnt, 2) - dat(2, k + 1);
        dat(11,k + 1) = AdamsExtarpolation2OrdSol(1 + k * cnt, 1) - dat(1, k + 1);
        dat(12,k + 1) = AdamsExtarpolation2OrdSol(1 + k * cnt, 2) - dat(2, k + 1);
    end
    
    ownA = eig(A);
    x1 = ownA(1);
    x2 = ownA(2);
    
    charNums = zeros(12, 2);
    charNums(1, 1) = x1;
    charNums(1, 2) = x2;
    charNums(3, 1) = 1 + h * x1;
    charNums(3, 2) = 1 + h * x2;
    charNums(5, 1) = 1 / (1 - h * x1);
    charNums(5, 2) = 1 / (1 - h * x2);
    charNums(7, 1) = (1 + h * x1 / 2) / (1 - h * x1 / 2);
    charNums(7, 2) = (1 + h * x2 / 2) / (1 - h * x2 / 2);
    tmp = solveSqrEquation((1+2/3*h*x1)/(1-5/12*h*x1), -(h*x1/12)/(1-5/12*h*x1));
    charNums(9, 1) = tmp(1);
    charNums(9, 2) = tmp(2);
    tmp = solveSqrEquation((1+2/3*h*x2)/(1-5/12*h*x2), -(h*x2/12)/(1-5/12*h*x2));
    charNums(10, 1) = tmp(1);
    charNums(10, 2) = tmp(2);
    tmp = solveSqrEquation(1+3/2*h*x1, -h*x1/2);
    charNums(11, 1) = tmp(1);
    charNums(11, 2) = tmp(2);
    tmp = solveSqrEquation(1+3/2*h*x2, -h*x2/2);
    charNums(12, 1) = tmp(1);
    charNums(12, 2) = tmp(2);
    
    rnames = {'“очное', '', 'ћ. Ёйлера', '', 'ќбр. м. Ёйлера', '', '»нт. м. јдамса 2 пор.', '', '»нт. м. јдамса 3 пор.', '', 'Ёкс. м. јдамса 2 пор.'};
    uitable('Parent', figure('Position', [200 200 900 400]), 'Position', [16 20 870 370], 'Data', [charNums, dat], 'ColumnName', {'’аракт.', 'числа', points}, 'RowName', rnames);
end

function [res] = getExactSolution(A, initY, points)
    syms y1(t) y2(t);
    eqn1 = diff(y1, 1) == A(1, 1) * y1 + A(1, 2) * y2;
    eqn2 = diff(y2, 1) == A(2, 1) * y1 + A(2, 2) * y2;
    cond = [y1(0) == initY(1), y2(0) == initY(2)];
    sol = dsolve(eqn1, eqn2, cond);
    
    res = zeros(size(points, 2), 2);
    for i = 1: size(points, 2)
        res(i, 1) = double(subs(sol.y1, t, points(i)));
        res(i, 2) = double(subs(sol.y2, t, points(i)));
    end
end

function [res] = explicitEiler(A, initY, h, cnt)
    W = eye(2) + h * A;
    res = zeros(cnt + 1, 2);
    res(1, 1) = initY(1, 1);
    res(1, 2) = initY(1, 2);
    for i = 1: cnt
        tmp = W * [res(i, 1); res(i, 2)];
        res(i + 1, 1) = tmp(1);
        res(i + 1, 2) = tmp(2);
    end
end

function [res] = implicitEiler(A, initY, h, cnt)
    W = (eye(2) - h * A) \ eye(2);
    res = zeros(cnt + 1, 2);
    res(1, 1) = initY(1, 1);
    res(1, 2) = initY(1, 2);
    for i = 1: cnt
        tmp = W * [res(i, 1); res(i, 2)];
        res(i + 1, 1) = tmp(1);
        res(i + 1, 2) = tmp(2);
    end
end

function [res] = AdamsInterpolation2Ord(A, initY, h, cnt)
    E = eye(2);
    W = (E - h * A / 2) \ (E + h * A / 2);
    res = zeros(cnt + 1, 2);
    res(1, 1) = initY(1);
    res(1, 2) = initY(2);
    
    for i = 1: cnt
        tmp = W * [res(i, 1); res(i, 2)];
        res(i + 1, 1) = tmp(1);
        res(i + 1, 2) = tmp(2);
    end
end

function [res] = AdamsInterpolation3Ord(A, initY, h, cnt)
    %сначала делаем јдамсом 2го пор€дка
    E = eye(2);
    hA = h * A;
    res = zeros(cnt + 1, 2);
    %{
    W = (E - hA / 2) \ (E + hA / 2);
    res(1, 1) = initY(1, 1);
    res(1, 2) = initY(1, 2);
    tmp = W * [initY(1, 1); initY(1, 2)];
    res(2, 1) = tmp(1);
    res(2, 2) = tmp(2);
    %}
    T = AdamsInterpolation2Ord(A, initY, h^2, 1/h);
    res(1, 1) = initY(1);
    res(1, 2) = initY(2);
    Ts = size(T, 1);
    res(2, 1) = T(Ts, 1);
    res(2, 2) = T(Ts, 2);
    
    Z = (E - 5/12 * hA) \ E;
    W1 = (E + 2/3 * hA) * Z;
    W2 = -hA / 12 * Z;
    for i = 2: cnt
        tmp = W1 * [res(i, 1); res(i, 2)] + W2 * [res(i - 1, 1); res(i - 1, 2)];
        res(i + 1, 1) = tmp(1);
        res(i + 1, 2) = tmp(2);
    end
end

function [res] = AdamsExtarpolation2Ord(A, initY, h, cnt)
    %сначала делаем јдамсом 2го пор€дка
    E = eye(2);
    hA = h * A;
    res = zeros(cnt + 1, 2);
    %{
    W = (E - hA / 2) \ (E + hA / 2);
    res(1, 1) = initY(1, 1);
    res(1, 2) = initY(1, 2);
    tmp = W * [initY(1, 1); initY(1, 2)];
    res(2, 1) = tmp(1);
    res(2, 2) = tmp(2);
    %}
    T = AdamsInterpolation2Ord(A, initY, h^2, 1/h);
    res(1, 1) = initY(1);
    res(1, 2) = initY(2);
    Ts = size(T, 1);
    res(2, 1) = T(Ts, 1);
    res(2, 2) = T(Ts, 2);
    
    W1 = E + 3/2 * hA;
    W2 = -hA/2;
    for i = 2: cnt
        tmp = W1 * [res(i, 1); res(i, 2)] + W2 * [res(i - 1, 1); res(i - 1, 2)];
        res(i + 1, 1) = tmp(1);
        res(i + 1, 2) = tmp(2);
    end
end

function [roots] = solveSqrEquation(w1, w2)
    roots = zeros(2);
    qD = sqrt(w1 * w1 + 4 * w2);
    roots(1) = (w1 + qD) / 2;
    roots(2) = (w1 - qD) / 2;
end