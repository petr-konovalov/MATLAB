function res = calcTheta(t)
    global w0 R L;
    res = -asin(R*w0/L*sin(t));
end