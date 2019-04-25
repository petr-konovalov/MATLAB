function res = calcM(q)
    global l1 r1 r2 m1 m2; 
    res = [2*m1*r1^2*cos(pi/4 + q(1))^2 - m2*(sin(2*q(1)) - 1)*(l1 + r2 - q(2))^2, 2*m2*(sin(q(1))^2 - 1/2)*(l1 + r2 - q(2)); -m2*cos(2*q(1))*(l1 + r2 - q(2)), m2*(sin(2*q(1)) + 1)];
end