function [K, L] = solve(A, B, C)
    K = nan;
    L = nan;
    n = size(B, 1);
    m = size(B, 2);
    l = size(C, 1);
    cvx_clear;
    cvx_begin sdp
        variable Y1(n, n) symmetric
        variable Y2(n, n) symmetric
        variables Z1(m, n) Z2(l, n)
        Y1 >= eye(n, n)
        Y2 >= eye(n, n)
        A*Y1+Y1*A'+Z1'*B'+B*Z1 <= -eye(n, n)
        A'*Y2+Y2*A+Z2'*C+C'*Z2 <= -eye(n, n)
    cvx_end
    if cvx_optval == 0
        K = Z1/Y1;
        L = Y2\Z2';
    end
end