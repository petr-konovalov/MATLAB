function U = motionControl(X, t, C, K, p, dp)
    U = C\revB*(dp(t)+K*(p(t)-X(t)));
end

function res = revB(th)
    res = [cos(th) sin(th) 0; -sin(th) cos(th) 0; 0 0 1];
end