function res = getDescreteSol(N)
    h = 1 / N;
    x = 0: h: 1;
    gPhi = phi(x);
    C = zeros(1, N - 1);
    res = zeros(6, 6);
    
    for p = 1: N - 1
        C(p) = gPhi * Xi(p, x)';
    end
    C = C * h;
    for i = 1: 6
        xi = (i - 1) * 0.2;
        for k = 1: 6
            tk = (k - 1) * 0.02;
            for p = 1: N - 1
                res(i, k) = res(i, k) + C(p) * T(p, tk) * sin(p * pi * xi);
            end
            res(i, k) = sqrt(2) * res(i, k);
        end
    end
end