function res = difEqOp(func, var)
    df = diff(func);
    d2f = diff(df);
    res = p(var) * d2f + q(var) * df + r(var) * func; 
end

function res = p(x)
    res = -1 / (x + 3);
end

function res = q(x)
    res = -x;
end

function res = r(x)
    res = log(2 + x);
end
