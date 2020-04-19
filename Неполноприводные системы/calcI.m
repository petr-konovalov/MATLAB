function res = calcI(X)
    global L l Theta0 dTheta0 g;
    th = X(2);
    dTh = X(4);
    res = dTh^2-((l-L*cos(Theta0)^2)/(l-L*cos(th)^2))^(1/L)*dTheta0^2+...
        2*g*integral(@(s)sin(s)./(L*cos(s).^2-l).*abs((l-L*cos(s).^2)/(l-L*cos(th).^2)).^(1/L), Theta0, th);
end