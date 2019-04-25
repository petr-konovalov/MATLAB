function projectiveMethods(n)
    global x funcs preCalcMatr;
    
    solex(@p, @q, @r, @f, 0, -1, 0, 1, 1/2, 0, -1, 1);
    
    if isempty(x) || isempty(funcs) || isempty(preCalcMatr)
        preCalcForProjectiveMethods;
    end
    
    A = preCalcMatr(1: n, 1: n);
    B = zeros(n, 1);
    for i = 1: n
        B(i) = L2Mult(f(x), funcs(i), x);
    end
    disp([A, B]);
    C = A \ B;
    galerkinApprox = simplify(funcs(1: n) * C);
    cnt = 200;
    step = 2 / cnt;
    X = -1: step: 1;
    Y = zeros(1, cnt + 1);
    for i = 1: cnt + 1
        Y(i) = double(subs(galerkinApprox, x, X(i)));
    end
    plot(X, Y, 'g');
    
    T = zeros(1, n);
    for i = 1: n
        T(i) = cos(pi * (2 * i - 1) / (2 * n));
    end
    for i = 1: n
        B(i) = f(T(i));
        for j = 1: n
            A(i, j) = double(subs(difEqOp(funcs(j), x), x, T(i)));
        end
    end
    C = A \ B;
    kollokApprox = simplify(funcs(1: n) * C);
    X = -1: step: 1;
    Y = zeros(1, cnt + 1);
    for i = 1: cnt + 1
        Y(i) = double(subs(kollokApprox, x, X(i)));
    end
    plot(X, Y, 'b');
end

function res = p(x)
    res = -1 / (x + 3);
end

function res = q(x)
    res = -x;
end

function res = r(x)
    res = log(2 + x);
end

function res = f(x)
    res = 1 - x / 2;
end