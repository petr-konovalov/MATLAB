function func = getCoordFunc(n, var)
    switch n
        case 1
            func = var ^ 2 + 2 * var - 11;
        case 2
            func = var ^ 3 - 3 * var + 2;
        otherwise
            func = jacobiP(n - 3, 2, 2, var) * (1 - var ^ 2) ^ 2;
    end
end
