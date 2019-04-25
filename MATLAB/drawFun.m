function drawFun(fun, l, r, step)
    X = l: step: r;
    cnt = numel(X);
    Y = zeros(1, cnt);
    for k = 1: cnt
        Y(k) = fun(X(k));
    end
    plot(X, Y);
end