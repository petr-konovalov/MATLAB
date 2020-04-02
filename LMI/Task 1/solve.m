function res = solve(A, Q, R, G, B)
    if checkConditions(A, Q, R, G, B)
        n = size(Q, 1);
        m = size(R, 1);
        setlmis([]);
        [P, VarCnt, PStr] = lmivar(1, [n, 1]);
        disp(PStr);
        lmi1 = newlmi;
        lmiterm([lmi1, 1, 1, P], -1, 1);
        lmi2 = newlmi;
        lmiterm([lmi2, 1, 1, P], 1, A, 's');
        lmiterm([lmi2, 1, 1, 0], Q);
        lmiterm([lmi2, 1, 1, P], G', G);
        lmiterm([lmi2, 1, 2, P], 1, B);
        lmiterm([lmi2, 2, 2, 0], -R);
        lmisys = getlmis;
        c = zeros(VarCnt, 1);
        for j = 1: VarCnt
            Pt = defcx(lmisys, j, P);
            c(j) = -trace(Pt);
        end
        [copt, xopt] = mincx(lmisys, c, [1e-4, 100, -1, 10, 0]);
        disp(copt);
        res = dec2mat(lmisys, xopt, P);
    else
        disp('Размерности не соответсвуют');
        res = 0;
    end
end

function res = checkConditions(A, Q, R, G, B)
    n = size(Q, 1);
    m = size(R, 1);
    
    if size(Q, 2) ~= n || size(R, 2) ~= m || size(B, 1) ~= n || size(B, 2) ~= m || size(G, 1) ~= n || size(G, 2) ~= n || size(A, 1) ~= n || size(A, 2) ~= n
        res = false;
    else
        res = true;
    end
end