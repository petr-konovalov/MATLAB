function res = L2Mult(f1, f2, l, r, x)
    eps = 1e-6;
    res = integral(@(t)double(subs(f1 * f2, x, t)), l, r, 'AbsTol', eps);
end

