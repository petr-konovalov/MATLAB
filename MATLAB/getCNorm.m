function res = getCNorm(fun, l, r)
    res = max(abs(fun(l)), abs(fun(r)));
    res = max(res, -fminbnd(@(t)-abs(fun(t)), l, r));
end