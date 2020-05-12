function n = getNorm(A, B, C)
    n = cross(B-A, C-A);
    n = n / norm(n);
end