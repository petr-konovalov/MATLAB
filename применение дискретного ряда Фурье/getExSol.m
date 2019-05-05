function res = getExSol(exSumSz)
    C = zeros(1, exSumSz);

    for p = 1: exSumSz
        C(p) = contScalMult(@phi, @(x)(Xi(p, x)));
    end
    
    res = zeros(6, 6);
    res(:, 1) = phi(0: 0.2: 1)';
    
    for i = 1: 6
        xi = (i - 1) * 0.2;
        for k = 2: 6
            tk = (k - 1) * 0.02;
            for p = 1: exSumSz
                res(i, k) = res(i, k) + C(p) * T(p, tk) * sin(p * pi * xi);
            end
            res(i, k) = sqrt(2) * res(i, k);
        end
    end
end