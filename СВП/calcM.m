function res = calcM(q)
    global l1 r1 r2 m1 m2; 
    res = [m1*r1^2 + m2*(l1 + r2 - q(2))^2, 0; 0, m2];
end