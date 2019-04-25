function difEquation2Ord()
    a1 = 1;
    a2 = 0;
    a  = 0;
    b1 = 1;
    b2 = 0;
    b  = 0;
    lf = -1;
    rg = 1;
    h = (rg - lf) / 10;
    Yex = solex(@p, @q, @r, @f, a1, a2, a, b1, b2, b, lf, rg);
    
    [A, B, C, G] = getABCGh(a1, a2, a, b1, b2, b, lf, rg, 10);
    [Y10h, s, t] = solve3DiagSystem(A, B, C, G);
    printIter(A, B, C, G, s, t, Y10h, lf, rg, 10);
    
    [A, B, C, G] = getABCGh(a1, a2, a, b1, b2, b, lf, rg, 20);
    [Y20h, ~, ~] = solve3DiagSystem(A, B, C, G);
    
    Yuth = zeros(11, 1);
    for k = 1: 11
        Yuth(k) = Y20h(1 + (k - 1) * 2) + (Y20h(1 + (k - 1) * 2) - Y10h(k)) / 3;
    end
    
    [A, B, C, G] = getABCGh2(a1, a2, a, b1, b2, b, lf, rg, 10);
    [Y10h2, s, t] = solve3DiagSystem(A, B, C, G);
    printIter(A, B, C, G, s, t, Y10h2, lf - h / 2, rg + h / 2, 11);
   
    [A, B, C, G] = getABCGh2(a1, a2, a, b1, b2, b, lf, rg, 20);
    [Y20h2, ~, ~] = solve3DiagSystem(A, B, C, G);
    
    Yuth2 = zeros(11, 1);
    for k = 1: 11
        Yh2 = (Y20h2(1 + (k - 1) * 2) + Y20h2(2 + (k - 1) * 2)) / 2;
        Yh = (Y10h2(k) + Y10h2(k + 1)) / 2;
        Yuth2(k) = Yh2 + (Yh2 - Yh) / 3;
    end
    
    printAns(Yex, Yuth, Yuth2, lf, rg, 10);
end

function printIter(A, B, C, G, s, t, Y, lf, rg, n)
    h = (rg - lf) / n;
    for k = 1: n + 1
        fprintf('%3d %4.1f %14.7e %14.7e %14.7e %14.7e %14.7e %14.7e %14.7e\n', k - 1, lf + h * (k - 1), A(k), B(k), C(k), G(k), s(k), t(k), Y(k));
    end
    fprintf('\n');
end

function printAns(Yex, Yuth, Yuth2, lf, rg, n)
    h = (rg - lf) / n;
    for k = 1: 11
        Yexv = Yex(1 + 4 * (k - 1));
        fprintf('%5.1f %10.7f %10.7f %14.7e %10.7f %14.7e\n', lf + (k - 1) * h, Yexv, Yuth(k), Yuth(k) - Yexv, Yuth2(k), Yuth2(k) - Yexv);
    end
    fprintf('\n');
end

function [A, B, C, G] = getABCG(lf, rg, n)
    h = (rg - lf) / n;
    
    A = zeros(1, n + 1);
    B = zeros(1, n + 1);
    C = zeros(1, n + 1);
    G = zeros(1, n + 1);
    
    for k = 2: n
        pk = -p(lf + (k - 1) * h);
        qk = q(lf + (k - 1) * h);
        
        A(k) = -pk / (h ^ 2) -  qk / (2 * h);
        B(k) = -(2 * pk / (h ^ 2) + r(lf + (k - 1) * h));
        C(k) = -pk / (h ^ 2) + qk / (2 * h);
        G(k) = f(lf + (k - 1) * h);
    end
end

function [A, B, C, G] = getABCGh(a1, a2, a, b1, b2, b, lf, rg, n)
    h = (rg - lf) / n;
    [A, B, C, G] = getABCG(lf, rg, n);
    
    A(1) = 0;
    C(1) = -a2 / h;
    B(1) = -a1 + C(1);
    G(1) = a;
    
    A(n + 1) = -b2 / h;
    B(n + 1) = -b1 + A(n + 1);
    C(n + 1) = 0;
    G(n + 1) = b;
end

function [A, B, C, G] = getABCGh2(a1, a2, a, b1, b2, b, lf, rg, n)
    h = (rg - lf) / n;
    [A, B, C, G] = getABCG(lf - h / 2, rg + h / 2, n + 1);
    
    A(1) = 0;
    B(1) = -a1 / 2 - a2 / h;
    C(1) = a1 / 2 - a2 / h;
    G(1) = a;
    
    A(n + 2) = b1 / 2 - b2 / h;
    B(n + 2) = -b1 / 2 - b2 / h;
    C(n + 2) = 0;
    G(n + 2) = b;
end

function [X] = p(x)
       X = -1 / (x - 3);
end
   
function [X] = q(x)
       X = 1 + x / 2;       
end

function [X] = r(x)
       X = -exp(x / 2); 
end

function [X] = f(x)
       X = 2 - x;       
end