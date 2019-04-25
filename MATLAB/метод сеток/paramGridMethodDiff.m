function u = paramGridMethodDiff(f, phi, alp, bet, N, M, T, sgm)
    A = zeros(1, N + 1);
    B = zeros(1, N + 1);
    C = zeros(1, N + 1);
    G = zeros(1, N + 1);
    u = zeros(M + 1, N + 1);
    tau = T / M;
    h = 1 / N;
    for j = 1: N + 1
        u(1, j) = phi((j - 1) * h);
    end
    
    cr = (sgm - 1) * tau;
    for k = 2: M + 1
        tk = (k - 1) * tau;
        t_k = tk + cr;
        for j = 2: N
            xj = (j - 1) * h;
            b = 1 + xj ^ 2;
            A(j) = sgm * (1 / (h ^ 2) - b / (2 * h));
            B(j) = 1 / tau + 2 * sgm / (h ^ 2);
            C(j) = sgm * (1 / (h ^ 2) + b / (2 * h));
            G(j) = -u(k - 1, j) / tau - (1 - sgm) * ((u(k - 1, j + 1) - 2 * u(k - 1, j) + u(k - 1, j - 1)) / (h ^ 2) + b * (u(k - 1, j + 1) - u(k - 1, j - 1)) / (2 * h)) - f(xj, t_k);
        end
        A(1) = 0;
        B(1) = -1;
        C(1) = 1;
        G(1) = h * alp(tk);
        A(N + 1) = -1;
        B(N + 1) = -1;
        C(N + 1) = 0;
        G(N + 1) = h * bet(tk);
        
        [Y, ~, ~] = solve3DiagSystem(A, B, C, G);
        for j = 1: N + 1
            u(k, j) = Y(j);
        end
    end
end