function [t, th] = getThetaApproxFun(Theta0, dTheta0, L, l, g)
    opts = odeset('RelTol', 1e-12);
    [t, th] = ode15s(@(t, y)getDTheta(t, y, Theta0, dTheta0, L, l, g), [0, 1], Theta0, opts);
end