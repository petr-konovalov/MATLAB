function res = calcB(X)
    global B g;
    res = [-X(4)*X(4)*B*sin(X(2)); -g*sin(X(2))];
end