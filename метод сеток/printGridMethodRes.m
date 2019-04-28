function printGridMethodRes(exSol, f, phi, alp, bet, N, M, M1, T, solFunc)
    fSolh = getSolveTableFast(f, phi, alp, bet, N, M, T, solFunc);
    fSolh2 = getSolveTableFast(f, phi, alp, bet, 2 * N, M1, T, solFunc);
    disp(fSolh);
    fprintf("%5.2f %5.3f %e %e\n", 1 / N, T / M, max(max(abs(exSol - fSolh))), max(max(abs(fSolh - fSolh2))));
end