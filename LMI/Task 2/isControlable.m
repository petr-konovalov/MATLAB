function res = isControlable(A, B)
    n = size(A, 1);
    m = size(B, 2);
    mtx = zeros(n, n * m);
    mtx(1:n, 1:m) = B;
    An = A;
    for k = 1: n - 1
        mtx(1:n, k*m+1:(k+1)*m) = An * B;
        An = An * A;
    end
    res = rank(mtx) == n;
end