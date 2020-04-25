function res = linSearchGFValArg(val, lt, rt, gt, gX)
    n = size(gt, 1);
    k = 1;
    res = [];
    while k < n
        if lt <= gt(k) && gt(k) <= rt && (gX(k) <= val && val < gX(k+1) || gX(k+1) <= val && val < gX(k))
            res = [res; gt(k)+(gt(k+1)-gt(k))*(val-gX(k))/(gX(k+1)-gX(k))];
        end
        k = k + 1;
    end
end