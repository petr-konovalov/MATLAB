function res = calcDTheta(t)
    global w0 R L;
    res = -cos(t)/sqrt((L/(w0*R))^2-sin(t)^2);
end