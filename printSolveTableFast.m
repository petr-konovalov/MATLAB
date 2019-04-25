function printSolveTableFast(f, phi, alp, bet, N, M, T, solFunc)
    hN   = round(N / 5);
    hM   = round(M / 5);
    
    res  = solFunc(f, phi, alp, bet, N, M, T);
    us   = zeros(6, 6);
    
    for k = 1: 6
        for j = 1: 6
            us(k, j) = res((k - 1) * hM + 1, (j - 1) * hN + 1);
        end
    end 
    
    disp(us);
end