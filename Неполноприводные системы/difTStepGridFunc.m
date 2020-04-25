function val = difTStepGridFunc(t, gt, gX)
    l = 1;
    r = size(gt, 1);
    while r - l > 1
        m = floor((l+r)*0.5);
        if gt(m) <= t
            l = m;
        else
            r = m;
        end
    end
    val = gX(l, :)+(t-gt(l))*(gX(l+1,:)-gX(l, :))/(gt(l+1)-gt(l));
end