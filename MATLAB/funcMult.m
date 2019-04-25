function res = funcMult(f1, f2, l, r, x, difEqOp)
    res = L2Mult(difEqOp(f1, x), f2, l, r, x);
end
