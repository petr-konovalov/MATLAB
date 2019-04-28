function u = param0GridMethodDiff(f, phi, alp, bet, N, M, T)
    u = zeros(M + 1, N + 1);
    tau = T / M;
    h = 1 / N;
    for j = 1: N + 1
        u(1, j) = phi((j - 1) * h);
    end
    
    for k = 2: M + 1
        tk_1 = (k - 2) * tau;
        for j = 2: N
            xj = (j - 1) * h;
            u(k, j) = u(k - 1, j) + tau * (((u(k - 1, j + 1) - 2 * u(k - 1, j) + u(k - 1, j - 1)) / (h * h)) + (1 + xj ^ 2) * (u(k - 1, j + 1) - u(k - 1, j - 1)) / (2 * h) + f(xj, tk_1));
        end
        tk = tk_1 + tau;
        u(k, 1) = u(k, 2) - alp(tk) * h;
        u(k, N + 1) = bet(tk) * h + u(k, N);
    end
end