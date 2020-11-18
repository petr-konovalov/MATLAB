A = [0.7 0; 0 0.5];
B = [1; 0.1];
C = [0, 1];
D = 1;

[g0, x0] = solve(A, B, C, D);
disp(g0);
%disp(x0);
disp(norm(ss(A, B, C, D, -1), inf));

function [g0, x0] = solve(A, B, C, D)    
    setlmis([]);
    n = size(A, 1);
    H = lmivar(1, [n, 1]);
    [G, ndec, ~] = lmivar(1, [1, 0]);
    lmi1 = newlmi;
    lmiterm([lmi1, 1, 1, H], A', A);
    lmiterm([lmi1, 1, 1, H], 1, -1);
    lmiterm([lmi1, 1, 2, H], A', B);
    lmiterm([lmi1, 1, 3, 0], C');
    lmiterm([lmi1, 2, 2, G], 1, -1);
    lmiterm([lmi1, 2, 2, H], B', B);
    lmiterm([lmi1, 2, 3, 0], D');
    lmiterm([lmi1, 3, 3, G], 1, -1);
    lmisys = getlmis;
    
    c = zeros(ndec, 1);
    c(ndec) = 1;
    [g0, x0] = mincx(lmisys, c);
end

