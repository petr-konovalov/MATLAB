function bis = getBisector(v1, v2)
    v1 = norm(v2) * v1 / norm(v1);
    bis = v1 + v2;
end