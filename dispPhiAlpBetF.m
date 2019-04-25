function dispPhiAlpBetF(u, x, t)
    udx  = simplify(diff(u, x));
    
    f = simplify(diff(u, t) - diff(udx, x) - (x ^ 2 + 1) * udx);
    phi = simplify(subs(u, t, 0));
    alp = simplify(subs(udx, x, 0));
    bet = simplify(subs(udx, x, 1));
    
    disp(phi);
    disp(alp);
    disp(bet);
    disp(f);
end