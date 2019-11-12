function res = Chebyshev(U_0, U_ex, hx, hy, fv, m, D, d)
    hx2 = hx * hx;
    hy2 = hy * hy;
    p = ceil(log(m) / log(2));
    n = 2 ^ p;
    tau = zeros(1, n);
    theta = getIterParams(p);
    for k = 1: n
        tau(k) = 2/(D+d+(D-d)*cos(theta(k)*pi/(2*n)));
    end
%     for k = 1: n
%         tau(k) = 2/(D+d+(D-d)*cos((2 * k - 1)*pi/(2*n)));
%     end
    
    U_k_1 = U_0;
    res = getNextApprox(size(U_0), U_k_1, fv, hx2, hy2, tau(1));
    for k = 2: n
        res = getNextApprox(size(U_0), U_k_1, fv, hx2, hy2, tau(k));
        %if mod(k, 5) == 0 || m <= 10
            printTable(k, U_0, res, U_k_1, U_ex, fv, hx, hy);
        %end
        U_k_1 = res;
    end
end

function res = getIterParams(p)
    if p > 0
        m = 2 ^ p;
        res = zeros(1, m);
        res(1: 2: m) = getIterParams(p - 1);
        res(2: 2: m) = 2 * m - res(1: 2: m);
    else
        res = 1;
    end
end

function res = getNextApprox(s, U, fv, hx2, hy2, t)
    res = zeros(s);
    
    res([1, s(1)], 1: s(2)) = U([1, s(1)], 1: s(2));
    for i = 2: s(1) - 1
        res(i, [1, s(2)]) = U(i, [1, s(2)]);
        for j = 2: s(2) - 1
            res(i,j)=U(i,j)+t*((U(i+1,j)-2*U(i,j)+U(i-1,j))/hx2+(U(i,j+1)-2*U(i,j)+U(i,j-1))/hy2+fv(i,j));
        end
    end
end