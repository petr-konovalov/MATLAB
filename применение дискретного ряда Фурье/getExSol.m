function res = getExSol(exSumSz)
    C = zeros(1, exSumSz);

    for p = 1: exSumSz
        C(p) = contScalMult(@phi, @(x)(Xi(p, x)));
    end
    
    res = zeros(6, 6);
    h = 1 / 5;
    tau = 0.1 / 5;
    
    for i = 1: 6
        xi = (i - 1) * h;
        for k = 1: 6
            tk = (k - 1) * tau;
            for p = 1: exSumSz
                res(i, k) = res(i, k) + C(p) * T(p, tk) * sin(p * pi * xi);
            end
        end
        res(i, k) = sqrt(2) * res(i, k);
    end
end