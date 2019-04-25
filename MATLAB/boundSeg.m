function res = boundSeg(bnd, x)
    if (x < bnd(1))
        res = bnd(1);
    elseif (x > bnd(2))
        res = bnd(2);
    else
        res = x;
    end
end