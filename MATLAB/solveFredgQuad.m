function sol = solveFredgQuad(H, f, x, y, n)
    X = zeros(1, 2 * n);
    t1 = -1 / sqrt(3);
    t2 =  1 / sqrt(3);
    len = 1 / n;
    A = len / 2;
    for k = 1: n
        a = len * (k - 1);
        b = len * k;
        X(2 * k - 1) = (a + b) / 2 + t1 * A;
        X(2 * k    ) = (a + b) / 2 + t2 * A;
    end
    D = eye(2 * n);
    g = zeros(2 * n, 1);
    for i = 1: 2 * n
        for j = 1: 2 * n
            D(i, j) = D(i, j) - A * double(subs(H, [x, y], [X(i), X(j)]));
        end
        g(i) = double(subs(f, x, X(i)));
    end
    z = D \ g;
    sol = f;
    for k = 1: 2 * n
        sol = sol + A * subs(H, y, X(k)) * z(k);
    end
end