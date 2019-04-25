function res = L2Norma(func, l, r, var)
    res = sqrt(L2Mult(func, func, l, r, var));
end