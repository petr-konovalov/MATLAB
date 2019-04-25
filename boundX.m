function res = boundX(X)
    res = zeros(4, 1);
    b1 = [-2 2] * 100;
    b2 = [-5 5] * 100;
    b3 = [-10 10] * 10000;
    b4 = [-10 10] * 10000;
    res(1) = boundSeg(b1, X(1));
    res(2) = boundSeg(b2, X(2));
    res(3) = boundSeg(b3, X(3));
    res(4) = boundSeg(b4, X(4));
end