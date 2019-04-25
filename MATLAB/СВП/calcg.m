function res = calcg(q)
    global l1 r1 r2 m1 m2 G;
    res = [G*cos(q(1))*(l1*m2 + m1*r1 + m2*r2 - m2*q(2)); -G*m2*sin(q(1))];
end