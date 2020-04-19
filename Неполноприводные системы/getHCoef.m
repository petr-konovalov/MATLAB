function res = getHCoef(Q, R, N, M, T)
    yalmip('clear');
    F = sdpvar(3);
    A = cell(M, 1);
    B = cell(M, 1);
    for k = 1: M
        A(k) = {sdpvar(3)};
        B(k) = {sdpvar(3)};
    end
    neq = [];
    for j = 1: N
        tj = (j-1)*T/N;
        dH = calcdH(tj, M, A, B, T);
        H = calcH(tj, M, F, A, B, T);
        vA = calcA(tj);
        vB = calcBB(tj);
        neq = [neq, [dH+H*vA+vA'*H+Q, H*vB; vB'*H, R] >= 0];
    end
    solvesdp(neq, -trace(F));
    res = zeros(2*M+1, 3, 3);
    res(1, :, :) = double(F);
    for k = 1: M
        res(2*k  , :, :) = double(A{k});
        res(2*k+1, :, :) = double(B{k});
    end
end