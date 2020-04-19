function res = calcK(t)
    global RR;
    res = -calcBB(t)'*cH(t)/RR;
end

function res = cH(t)
    global HCoef M_ T;
    w = 2*pi/T;
    res = reshape(HCoef(1, :, :), 3, 3);
    for k = 1: M_
        Ak = reshape(HCoef(2*k, :, :), 3, 3);
        Bk = reshape(HCoef(2*k+1, :, :), 3, 3);
        res = res+Ak*cos(k*w*t)+Bk*sin(k*w*t);
    end
end