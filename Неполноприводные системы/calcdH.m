function res = calcdH(t, M, A, B, T)
    w = 2*pi/T;
    res = 0;
    for k = 1: M
        res = res + k*B{k}*cos(k*w*t)-k*A{k}*sin(k*w*t);
    end
    res = w*res;
end