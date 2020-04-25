function res = calcU(X)
    global C l L B R A g;
    th = X(2);
    dTh = X(4);
    tau = fminsearch(@(t)(th-calcTheta(t))^2+(dTh-calcDTheta(t))^2, 0);
    SX = [calcI(X); calcDY(X); calcY(X)];
    KX = calcK(tau)*SX;
    res = [((C*l+B*R*sin(th)^2)*KX+sin(th)*(A*L/R-B)*(dTh^2*l-g*cos(th)))/(l-L*cos(th)^2); 0];
end