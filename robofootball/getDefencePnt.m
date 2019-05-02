%AB - goal segment
%O  - robot position
%Q  - opponent robot position
%k  - O speed divided by Q speed

function pnt = getDefencePnt(A, B, O, Q, k)
    v = getBisector(A - Q, B - Q);
    v = v / norm(v);
    u = Q - O;
    uv = dot(u, v);
    uu = dot(u, u);
    
    t = -1;
    if k == 1
        if uv < 0
            t = -uu / (2 * uv);
        end
    else
        kk = k * k;
        A = kk - 1;
        B = uv * kk;
        C = uu * kk;
        D = B * B - A * C;
        if D >= 0
            sqD = sqrt(D);
            t = (-B - sqD) / A; 
            if t < 0
                t = (-B + sqD) / A;
            end
        end
    end
    
    disp(t);
    if t <= 0
        pnt = O;
    else
        pnt = Q + t * v;
    end
end