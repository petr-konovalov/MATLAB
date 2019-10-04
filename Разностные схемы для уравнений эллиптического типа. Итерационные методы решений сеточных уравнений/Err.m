function res = Err(U, f, hx, hy)
    res = calcNorm(Lh(U, hx, hy) + f);
end