function res = calcEnergy(X)
    global l1 r1 r2 m1 m2 G;
    
    q1   = X(1);
    q2   = X(2);
    dq1  = X(3);
    dq2  = X(4);
    dxm1 = -dq1 * r1 * sin(q1);
    dym1 = dq1 * r1 * cos(q1);
    dxm2 = -cos(q1) * dq2 - sin(q1) * dq1 * (l1 + r2 - q2);
    dym2 = cos(q1) * dq1 * (l1 + r2 - q2) - sin(q1) * dq2;
    ym1 = r1 * sin(q1);
    ym2 = (l1 + r2 - q2) * sin(q1);
    
    T = 0.5 * m1 * (dxm1 ^ 2 + dym1 ^ 2) + 0.5 * m2 * (dxm2 ^ 2 + dym2 ^ 2);
    P = m1 * G * ym1 + m2 * G * ym2;
    
    res = T + P;
end