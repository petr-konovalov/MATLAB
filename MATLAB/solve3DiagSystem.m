function [Y, s, t] = solve3DiagSystem(A, B, C, G)
    n = numel(A);
    Y = zeros(n, 1);
    s = zeros(n, 1);
    t = zeros(n, 1);
    s(1) = C(1) / B(1);
    t(1) = -G(1) / B(1);
    for k = 2: n
        zn = B(k) - A(k) * s(k - 1);
        s(k) = C(k) / zn;
        t(k) = (A(k) * t(k - 1) - G(k)) / zn;
    end
    Y(n) = t(n);
    for k = n - 1: -1: 1
        Y(k) = s(k) * Y(k + 1) + t(k);
    end
end

