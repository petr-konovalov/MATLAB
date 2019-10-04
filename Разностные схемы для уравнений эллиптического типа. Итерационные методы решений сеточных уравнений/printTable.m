function printTable(iter, U_0, U_k, U_k_1, U_ex, fv, hx, hy, U_k_2, ro)
    F_AUk = Err(U_k, fv, hx, hy);
    Uk_Uex = calcNorm(U_k - U_ex);
    Uk_Uk1 = calcNorm(U_k - U_k_1);
    fprintf("%5d %15e %15e %15e %15e %15e", iter, F_AUk, F_AUk/Err(U_0, fv, hx, hy), ...
        Uk_Uex, Uk_Uex/calcNorm(U_0-U_ex), Uk_Uk1);
    if nargin == 8
        fprintf("\n");
    elseif nargin == 10
        rok = Uk_Uk1 / calcNorm(U_k_1 - U_k_2);
        fprintf(" %15e %15f\n", ro*Uk_Uk1/(1-ro), rok);
    end
end