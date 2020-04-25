function dth = getDTheta(t, th, Theta0, dTheta0, L, l, g)
    zn = l-L*cos(th).^2;
    dth2 = ((l-L*cos(Theta0)^2)./zn).^(1/L)*dTheta0.^2-...
        2*g*integral(@(s)sin(s)./(L*cos(s).^2-l).*abs((l-L*cos(s).^2)./zn).^(1/L), Theta0, th);
    dth = sqrt(abs(dth2))*sign(dth2);
end