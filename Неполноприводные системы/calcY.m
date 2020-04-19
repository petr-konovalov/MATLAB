function res = calcY(X)
    global R L a;
    res = X(1)-(a-L*sin(X(2)))/R;
end