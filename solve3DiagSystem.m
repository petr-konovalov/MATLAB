% Solve system
% | -B(1)  C(1)    0    0    0   ...    0       0      0  |   |  Y(1) |   |  G(1) |
% |  A(2) -B(2)  C(2)   0    0   ...    0       0      0  |   |  Y(2) |   |  G(2) |
% |    0   A(3) -B(3) C(3)   0   ...    0       0      0  | * |  Y(3) | = |  G(3) |
% |  . . . . . . . . . . . . . . . . . . . . . . . . . .  |   | ..... |   | ..... |
% |    0     0     0    0    0   ... A(n-1) -B(n-1) C(n-1)|   | Y(n-1)|   | G(n-1)|
% |    0     0     0    0    0   ...    0     A(n)  -B(n) |   |  Y(n) |   |  G(n) |                            

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

