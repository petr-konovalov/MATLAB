function res = glueAngle(ang)
    res = ang;
    vp = [cos(ang(1)), sin(ang(1))];
    res(1) = ang(1);
    for k = 2:numel(ang)
        v = [cos(ang(k)), sin(ang(k))];
        dang = getAngle(vp, v);
        res(k) = res(k-1) + dang;
        %res(k) = dang();
        vp = v;
    end
end

function res = getAngle(u, v)
    res = atan2(vectMult(u, v), scalMult(u, v));
end

function res = scalMult(u, v)
    res = u(1) * v(1) + u(2) * v(2);
end

function res = vectMult(u, v)
    res = u(1) * v(2) - u(2) * v(1);
end

