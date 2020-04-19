function res = calcH(t, M, F, A, B, T)
    w = 2*pi/T;
    res = F;
    for k = 1: M
        res = res + A{k}*cos(k*w*t)+B{k}*sin(k*w*t);
    end
end