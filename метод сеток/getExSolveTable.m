function sol = getExSolveTable(u, x, t)
    sol = zeros(6, 6);
    for k = 1: 6
        for j = 1: 6
            sol(k, j) = double(subs(u, [x, t], [(j - 1) / 5, (k - 1) / 50]));
        end
    end
end