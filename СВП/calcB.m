function res = calcB(X)
    global l1 r1 r2 m1 m2 G;
    q1 = X(1);
    q2 = X(2);
    dq1 = X(3);
    dq2 = X(4);

    res = [G*cos(q1)*(l1*m2 + m1*r1 + m2*r2 - m2*q2) - 2*m2*dq1*dq2*(l1 + r2 - q2); l1*m2*dq1^2 + m2*r2*dq1^2 - G*m2*sin(q1) - m2*q2*dq1^2];
end