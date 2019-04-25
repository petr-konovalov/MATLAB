
%O - ball position
%Q - robots positions
%R - robot radius
%k - ball speed diveded by robot speed

function res = getDefenceArea(O, Q, R, k)
    res = zeros(size(Q, 1), 3);
    for j = 1: size(Q, 1)
        v = Q(j, :) - O;
        D = norm(v);
        p = 1 / (k ^ 2 - 1);
        res(j, 3) = k * D * p + R;
        res(j, [1, 2]) = Q(j, :) + v * p;
    end
end