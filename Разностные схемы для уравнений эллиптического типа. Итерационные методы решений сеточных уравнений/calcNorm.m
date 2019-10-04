function res = calcNorm(V)
    res = 0;
    for i = 2: size(V, 1) - 1
        for j = 2: size(V, 2) - 1
            res = max(res, abs(V(i, j)));
        end
    end
end