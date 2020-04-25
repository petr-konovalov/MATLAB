function dX = ssEq(t, X)
    global l L g;
    dX = zeros(2, 1);
    zn = l-L*cos(X(1))^2;
    dX(1) = X(2);
    dX(2) = g*sin(X(1))/zn-L*X(2)^2*sin(X(1))*cos(X(1))/zn;
end