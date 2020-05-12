function res = compareFormation(X0, X)
    r1_0 = X0(1:3);
    r2_0 = X0(4:6);
    r3_0 = X0(7:9);
    r1 = X(1:3)';
    r2 = X(4:6)';
    r3 = X(7:9)';
    res = max([abs(norm(r1_0-r2_0)-norm(r1-r2)), abs(norm(r2_0-r3_0)-norm(r2-r3)), abs(norm(r1_0-r3_0)-norm(r1-r3))]);
end