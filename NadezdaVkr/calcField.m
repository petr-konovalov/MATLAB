function res = calcField(r)
    global fieldGrad
    c = 0;
    res = linField(r, fieldGrad, c);
end