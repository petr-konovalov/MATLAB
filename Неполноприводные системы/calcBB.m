function res = calcBB(t)
    global R L l;
    %res = [2*R*R*cos(t)/(l*L-L*L+R*R*sin(t)*sin(t)); 1; 0];
    th = calcTheta(t);
    dTh = calcDTheta(t);
    res = [-2*dTh*R*cos(th)/(l-L*cos(th)^2); 1; 0];
end