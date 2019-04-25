function res = boundU(u)
    bnd1 = [-500 500];
    bnd2 = [-5 5] * 1e-3;
    res = [boundSeg(bnd1, u(1)); boundSeg(bnd2, u(2))];
end