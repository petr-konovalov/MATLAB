function res = diffDirectScheme(U_0, U_ex, N, M, hx, hy, fv, m, tau)    
    A_ = [ 0,   tau / (2 * hx * hx) * ones(1, N - 1),  0];
    B_ = [-1, (1 + tau / (hx * hx)) * ones(1, N - 1), -1];
    C_ = [ 0,   tau / (2 * hx * hx) * ones(1, N - 1),  0];
    
    A__ = [ 0,   tau / (2 * hy * hy) * ones(1, M - 1),  0];
    B__ = [-1, (1 + tau / (hy * hy)) * ones(1, M - 1), -1];
    C__ = [ 0,   tau / (2 * hy * hy) * ones(1, M - 1),  0];
    
    res = U_0;
    U_kp1 = getNextApprox(res, N, M, hx, hy, fv, tau, A_, B_, C_, A__, B__, C__);
    
    for k = 2: m
        printTable(k, U_0, U_kp1, res, U_ex, fv, hx, hy);
        res = U_kp1;
        U_kp1 = getNextApprox(res, N, M, hx, hy, fv, tau, A_, B_, C_, A__, B__, C__);
    end
end

function res = getNextApprox(U_k, N, M, hx, hy, fv, tau, A_, B_, C_, A__, B__, C__)
    res = zeros(N + 1, M + 1);
    res([1, N + 1], 1: M + 1) = mU([0, N * hx]', 1: M + 1);
    U_kd2 = U_k;
    
    G_ = zeros(1, N + 1);
    for j = 2: M
        G_(1) = mU(0, (j - 1) * hy);
        G_(N + 1) = mU(N * hx, (j - 1) * hy);
        for i = 2: N
            G_(i) = -U_k(i,j)-tau/2*((U_k(i,j+1)-2*U_k(i,j)+U_k(i,j-1))/(hy*hy)+fv(i,j));
        end
        [U_kd2(1: N + 1, j), ~, ~] = solve3DiagSystem(A_, B_, C_, G_);
    end
    
    G__ = zeros(1, M + 1);
    for i = 2: N
        G__(1) = mU((i - 1) * hx, 0);
        G__(M + 1) = mU((i - 1) * hx, M * hy);
        for j = 2: M
            G__(j) = -U_kd2(i,j)-tau/2*((U_kd2(i+1,j)-2*U_kd2(i,j)+U_kd2(i-1,j))/(hx*hx)+fv(i,j));
        end
        [res(i, 1: M + 1), ~, ~] = solve3DiagSystem(A__, B__, C__, G__);
    end
end
