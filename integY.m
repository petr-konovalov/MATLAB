function res = integY(symfun, x, y, t)
    X = 0: 0.25: 1;
    Y = zeros(1, numel(X));
    for k = 1: numel(X)
        Y(k) = double(subs(symfun, [x, y], [t, X(k)]));
    end
    res = trapz(X, Y);
end