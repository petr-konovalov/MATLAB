function [t, X] = solveSsEq(th0, dth0)
    opts = odeset('RelTol', 1e-12);
    [t, X] = ode15s(@(t, X)ssEq(t, X), [0, 10], [th0, dth0], opts);
end