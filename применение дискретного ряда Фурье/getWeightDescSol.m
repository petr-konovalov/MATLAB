function res = getWeightDescSol(N, M, sgm)
    h = 1 / N;
    tau = 0.1 / M;
    x = 0: h: 1;
    gPhi = phi(x);
    C = zeros(1, N - 1);
    res = zeros(6, 6);
    res(:, 1) = phi(0: 0.2: 1)';
    
    for p = 1: N - 1
        C(p) = gPhi * Xi(p, x)';
    end
    C = C * h;
    
    for i = 1: 6
        xi = (i - 1) * 0.2;
        for j = 2: 6
            tj = (j - 1) * 0.02;
            k = round(tj / tau);
            for p = 1: N - 1
                res(i, j) = res(i, j) + C(p) * (lmda(p, sgm, tau, h)) ^ k * sin(p * pi * xi);
            end
            res(i, j) = sqrt(2) * res(i, j);
        end
    end
end