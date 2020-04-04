function res = solve(A, Q, R, G, B, eps)
    if nargin < 6
        eps = 1e-6;
    end
    if checkConditions(A, Q, R, G, B)
        n = size(Q, 1);
        P = sdpvar(n);
        solvesdp([P>0, [P*A+A'*P+Q+G'*P*G P*B; B'*P -R]<0], -trace(P),...
            sdpsettings('solver', 'sedumi', 'shift', eps));
        res = double(P);
    else
        disp('Размерности не соответсвуют');
        res = nan;
    end
end

function res = checkConditions(A, Q, R, G, B)
    n = size(Q, 1);
    m = size(R, 1);
    
    if size(Q, 2) ~= n || size(R, 2) ~= m || size(B, 1) ~= n || ...
            size(B, 2) ~= m || size(G, 1) ~= n || size(G, 2) ~= n || ...
            size(A, 1) ~= n || size(A, 2) ~= n
        res = false;
    else
        res = true;
    end
end