function printTable(bpr, mID, iter, U_0, U_k, U_k_1, U_ex, fv, hx, hy, U_k_2, ro)
    global ItRes State eps;
    F_AUk = Err(U_k, fv, hx, hy);
    Uk_Uex = calcNorm(U_k - U_ex);
    Uk_Uk1 = calcNorm(U_k - U_k_1);
    RelD = F_AUk/Err(U_0, fv, hx, hy);
    %disp(ItRes(mID, Sstate) ~= 1);
    %disp(ItRes(mID, State) == 0);
    if RelD < eps && ItRes(mID, State) == 0
        ItRes(mID, State) = iter;
    end
    if bpr
        fprintf("%5d %15e %15e %15e %15e %15e", iter, F_AUk, RelD, ...
            Uk_Uex, Uk_Uex/calcNorm(U_0-U_ex), Uk_Uk1);
        if nargin == 10
            fprintf("\n");
        elseif nargin == 12
            rok = Uk_Uk1 / calcNorm(U_k_1 - U_k_2);
            fprintf(" %15e %15f\n", ro*Uk_Uk1/(1-ro), rok);
        end
    end
end