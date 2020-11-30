function res = remOutliers(X, R)
    res = zeros(1, numel(X));
    for k = 2:numel(X)
        if abs(X(k-1)-X(k)) > R
            res(k) = false;
            X(k) = X(k-1);
        else
            res(k) = true;
        end
    end
end