function res = altTriangularMethod(U_0, U_ex, hx, hy, fv, m, k1, k2, tau)    
    U_k_1 = U_0;
    res = getNextApprox(size(U_0), U_k_1, fv, hx, hy, k1, k2, tau);
    for k = 2: m
        res = getNextApprox(size(U_0), U_k_1, fv, hx, hy, k1, k2, tau);
        printTable(mod(k, 5) == 0 || m <= 10, 4, k, U_0, res, U_k_1, U_ex, fv, hx, hy);
        U_k_1 = res;
    end
    printTable(true, 4, m, U_0, res, U_k_1, U_ex, fv, hx, hy);
end

function res = getNextApprox(s, U, fv, hx, hy, k1, k2, t)
    W = zeros(s);
    u = U;
    u(1: s(1), [1, s(2)]) = mU((0: s(1) - 1)' * hx, [0, s(2) - 1] * hy);
    u([1, s(1)], 2: s(2) - 1) = mU([0; s(1) - 1] * hx, (1: s(2) - 2) * hy);
    
    Phi = Lh(u, hx, hy) + fv;
    for i = 2: s(1) - 1
        for j = 2: s(2) - 1
            W(i, j) = (k1*W(i-1,j)+k2*W(i,j-1)+Phi(i,j))/(1+k1+k2); 
        end
    end
    Wk = zeros(s);
    for i = s(1) - 1: -1: 2
        for j = s(2) - 1: -1: 2
            Wk(i, j) = (k1*Wk(i+1,j)+k2*Wk(i,j+1)+W(i,j))/(1+k1+k2);
        end
    end
    
    res = U + t * Wk;
end