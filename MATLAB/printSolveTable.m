function printSolveTable(u, x, t, N, M, T, solFunc)
    fsym = simplify(diff(u, t) - diff(u, x, x) - (x ^ 2 + 1) * diff(u, x));
    udx  = simplify(diff(u, x));
    f    = @(xx, tt)(double(subs(fsym, [x, t], [xx, tt])));
    phi  = @(xx)(double(subs(u, [x, t], [xx, 0])));
    alp  = @(tt)(double(subs(udx, [x, t], [0, tt])));
    bet  = @(tt)(double(subs(udx, [x, t], [1, tt])));
    
    printSolveTableFast(f, phi, alp, bet, N, M, T, solFunc);
end 