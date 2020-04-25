function res = calcDY(X)
    global L R;
    res = X(3)+L/R*cos(X(2))*X(4);
end