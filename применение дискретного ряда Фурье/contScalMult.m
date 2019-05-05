function res = contScalMult(f1, f2)
    eps = 1e-6;
    res = integral(@(x)(f1(x) .* f2(x)), 0, 1, 'AbsTol', eps);
end