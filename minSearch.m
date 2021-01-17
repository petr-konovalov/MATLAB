function res = minSearch(f, T)
    res = T(1);
    fres = f(res);
    for t = T
        if f(t) < fres
            res = t;
            fres = f(res);
        end
    end
end