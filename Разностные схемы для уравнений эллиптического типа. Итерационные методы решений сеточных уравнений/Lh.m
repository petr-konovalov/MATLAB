function res = Lh(U, hx, hy)
    res = zeros(size(U, 1), size(U, 2));
    hx2 = hx * hx;
    hy2 = hy * hy;
    for i = 2: size(U, 1) - 1
        for j = 2: size(U, 2) - 1
            res(i,j)=(U(i+1,j)-2*U(i,j)+U(i-1,j))/hx2+(U(i,j+1)-2*U(i,j)+U(i,j-1))/hy2;
        end
    end
end