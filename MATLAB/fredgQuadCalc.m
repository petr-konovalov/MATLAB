function fredgQuadCalc(H, f, x, y, eps)
    n = 4;
    u1 = solveFredgQuad(H, f, x, y, 1);
    u2 = solveFredgQuad(H, f, x, y, 2);
    printVals(u1, x);
    printVals(u2, x);
    m1 = double(subs(u1 - u2, x, 0));
    m2 = double(subs(u1 - u2, x, 1/2));
    m3 = double(subs(u1 - u2, x, 1));
    while max(abs(m1), max(abs(m2), abs(m3))) >= eps
        u1 = u2;
        u2 = solveFredgQuad(H, f, x, y, n);
        printVals(u2, x);
        n = n * 2;
        m1 = double(subs(u1 - u2, x, 0));
        m2 = double(subs(u1 - u2, x, 1/2));
        m3 = double(subs(u1 - u2, x, 1));
    end
    fprintf("\n%20e%20e%20e\n", m1, m2, m3);
end

function printVals(u, x)
    fprintf("%20.15f%20.15f%20.15f\n", double(subs(u, x, 0)), double(subs(u, x, 0.5)), double(subs(u, x, 1)));
end