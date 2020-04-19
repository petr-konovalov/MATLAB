function res = calcA(t)
    global l L;
    th = calcTheta(t);
    dTh = calcDTheta(t);
    %res = [-2*R*R*cos(t)*sin(t)/(l*L-L*L+R*R*sin(t)*sin(t)) 0 0; 0 0 0; 0 1 0];
    res = [-2*dTh*L*cos(th)*sin(th)/(l-L*cos(th)^2) 0 0; 0 0 0; 0 1 0];
end