function [L, X] = yakobyMethod(A, eps)
    X = eye(size(A, 1));
    L = A;
    
    while true
        ik = 1;
        jk = 2;
        sum = 0;
        for i = 1: size(L, 1)
            for j = i + 1: size(L, 2)
                if abs(L(i, j)) > abs(L(ik, jk))
                    ik = i;
                    jk = j;
                end
                sum = sum + abs(L(i, j));
            end
        end
        if sum < eps
           break; 
        end
        
        rrr = L(ik, ik) - L(jk, jk);
        d = (rrr ^ 2 + 4 * L(ik, jk) ^ 2) ^ 0.5;
        ppp = abs(rrr) / d;
        c = ((1 + ppp) / 2) ^ 0.5;
        s = sg(L(ik, jk) * rrr) * ((1 - ppp) / 2) ^ 0.5;
        
        for i = 1: size(L, 1)
            if i ~= ik && i ~= jk
                lii = L(i, ik);
                lij = L(i, jk);
                L(i, ik) =  c * lii + s * lij;
                L(ik, i) = L(i, ik);
                L(i, jk) = -s * lii + c * lij;
                L(jk, i) = L(i, jk);
            end
            xii = X(i, ik);
            xij = X(i, jk);
            X(i, ik) =  c * xii + s * xij;
            X(i, jk) = -s * xii + c * xij;
        end
        lii = L(ik, ik);
        lij = L(ik, jk);
        ljj = L(jk, jk);
        L(ik, ik) = c ^ 2 * lii + 2 * c * s * lij + s ^ 2 * ljj;
        L(jk, jk) = s ^ 2 * lii - 2 * c * s * lij + c ^ 2 * ljj;
        L(ik, jk) = 0;
        L(jk, ik) = 0;
    end
end

function [res] = sg(arg)
    if arg >= 0
        res = 1;
    else
        res = -1;
    end
end

