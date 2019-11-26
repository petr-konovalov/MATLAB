function printSolution(Sol, N, M)
    sN = floor(0.2 * N);
    sM = floor(0.2 * M);
    for i= 1: sN: N + 1
        for j = 1: sM: M + 1
            fprintf("%15.7f", Sol(i, j));
        end
        fprintf("\n");
    end
end