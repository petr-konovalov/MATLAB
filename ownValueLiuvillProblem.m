function ownValueLiuvillProblem()
    syms x;
    
    %В тетрадке вывел
    v1 = vpasolve(3*x+tan(x)==0, x, pi/2+0.1);
    v2 = vpasolve(3*x+tan(x)==0, x, 3*pi/2+0.1);
    
    minLda1 = v1^2+2;
    minLda2 = v2^2+2;
    maxLda1 = (1+sin(1/2))*v1^2+5;
    maxLda2 = (1+sin(1/2))*v2^2+5;
    
    y1 = sin(v1*x);
    y2 = sin(v2*x);
    y1 = y1 / L2Norma(y1, 0, 1, x);
    y2 = y2 / L2Norma(y2, 0, 1, x);
    
    fprintf('%7s%17s%9s%17s%9s\n', '', 'lambda1', '', 'lambda2', '');
    fprintf('%7s%13s%13s%13s%13s\n', '', 'Оценки', 'Невязки', 'Оценки', 'Невязки');
    fprintf('%7s%13.9f%13.9f%13.9f%13.9f\n', 'min', minLda1, getErr(y1, minLda1, x), minLda2, getErr(y2, minLda2, x));
    fprintf('%7s%13.9f%13.9f%13.9f%13.9f\n', 'max', maxLda1, getErr(y1, maxLda1, x), maxLda2, getErr(y2, maxLda2, x));
    
    appLda1 = funcMult(y1, y1, 0, 1, x, @opL);
    appLda2 = funcMult(y2, y2, 0, 1, x, @opL);
    fprintf('%7s%13.9f%13.9f%13.9f%13.9f\n', 'approx', appLda1, getErr(y1, appLda1, x), appLda2, getErr(y2, appLda2, x));
    
    global GL funcs;
    if (isempty(GL) || isempty(funcs))
        size = 7;
        GL= zeros(size);
        funcs=sym(zeros(1, size));
        for i = 1: size
            funcs(i) = getFunc(i, x);
        end
        for i = 1: size
            for j = i: size
                GL(i, j)= fScalMult(funcs(i), funcs(j), 0, 1, x, @p, @q);
            end
        end
        for i = 2: size
            for j = 1: i - 1
                GL(i, j) = GL(j, i);
            end
        end
    end
    
    ex = eig(GL);
    fprintf('%7s%13.9f%13s%13.9f%13s\n', 'exact', ex(1), '', ex(2), '');
    
    fprintf('\n----------Метод обратных итераций----------\n');
    for n = 3: 7
        [app, vect] = revIter(GL(1:n, 1:n), 1e-8);
        ownF = funcs(1, 1:n) * vect;
        ownF = ownF / L2Norma(ownF, 0, 1, x);
        
        fprintf('%13.9f%13.9f%13.9f\n', app, app - ex(1), getDif(ownF, app, x));
    end
end

function [val, vect] = revIter(M, eps)
    v = ones(size(M, 1), 1);
    vect = M \ v;
    prev = v(1) / vect(1);
    v = vect;
    vect = M \ vect;
    val = v(1) / vect(1);
    
    while abs(prev - val) >= eps
        prev = val;
        v = vect;
        vect = M \ vect;
        val = v(1) / vect(1);
    end
end

function res = getErr(y, lda, x)
    res = L2Norma(opL(y, x)-lda*y, 0, 1, x);
end

function dif = getDif(y, v, x)
    dif = double(subs(opL(y, x) - v * y, x, 1/2));
end

function func = getFunc(k, x)
    func = 2 * x * jacobiP(k - 1, 0, 2, 2 * x - 1);
    func = func / L2Norma(func, 0, 1, x);
end

function res = fScalMult(f1, f2, l, r, x, p, q)
    eps = 1e-6;
    res = integral(@(t)double(subs(p(x) * diff(f1) * diff(f2) + q(x) * f1 * f2, x, t)), l, r, 'AbsTol', eps);
    res = res + 1/3*p(r)*double(subs(f1*f2, x, r));
end

function res = opL(u, x)
    res = -diff(p(x) * diff(u)) + q(x) * u;
end

function res = p(x)
    res = 1 + sin(x / 2);
end

function res = q(x)
    res = 2 + 3 * x;
end
