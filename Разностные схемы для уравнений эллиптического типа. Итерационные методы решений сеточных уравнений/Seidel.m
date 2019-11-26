function res = Seidel(U_0, U_ex, hx, hy, fv, m, ro)
    hx2 = hx * hx;
    hy2 = hy * hy;
    U_k_2 = U_0;
    U_k_1 = getNextApprox(size(U_0), U_k_2, fv, hx2, hy2);
    res = getNextApprox(size(U_0), U_k_1, fv, hx2, hy2);
    for k = 2: m
        res = getNextApprox(size(U_0), U_k_1, fv, hx2, hy2);
        printTable(mod(k, 5) == 0 || m <= 10, 2, k, U_0, res, U_k_1, U_ex, fv, hx, hy, U_k_2, ro);
        U_k_2 = U_k_1;
        U_k_1 = res;
    end
end

function res = getNextApprox(s, U, fv, hx2, hy2)
    res = zeros(s);
    
    res([1, s(1)], 1: s(2)) = U([1, s(1)], 1: s(2));
    for i = 2: s(1) - 1
        res(i, [1, s(2)]) = U(i, [1, s(2)]);
        for j = 2: s(2) - 1
            res(i, j) = ((res(i-1,j)+U(i+1,j))/hx2+(res(i,j-1)+...
                U(i,j+1))/hy2+fv(i,j))/(2/hx2+2/hy2);
        end
    end
end

