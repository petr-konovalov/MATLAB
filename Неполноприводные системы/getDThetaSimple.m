function dth = getDThetaSimple(t, th, Theta0, dTheta0, L, l, g)
    C = dTheta0^2*(L*cos(th)^2-l)-2*g*cos(Theta0);
    dth2 = (C+2*g*cos(th))/(L*cos(th)^2-l);
    dth = sqrt(dth2);
end