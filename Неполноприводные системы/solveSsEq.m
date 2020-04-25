function [t, X] = solveSsEq(th0, dth0, TStart, TFinish)
    opts = odeset('RelTol', 1e-12);
    [t, X] = ode15s(@(t, X)ssEq(t, X), [TStart, TFinish], [th0, dth0], opts);
end