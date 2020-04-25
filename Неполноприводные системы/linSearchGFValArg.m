function res = linSearchGFValArg(val, lt, rt, gt, gX)
    n = size(gt, 1);
    k = 1;
    while ~(lt <= gt(k) && gt(k) <= rt && gX(k) <= val && val < gX(k+1)) && k <= n
        k = k + 1;
    end
    res = gt(k)+(gt(k+1)-gt(k))*(val-gX(k))/(gX(k+1)-gX(k));
end