n = 256;
k = 2;
A = zeros(1, n);

for j = 1: n
    A(j) = j;
end

pos = mod(k - 1, n);
for j = 1: n - 1
    cnt = 0;
    A(pos + 1) = -1;
    while (cnt < k)
        pos = mod(pos + 1, n);
        if A(pos + 1) ~= -1
            cnt = cnt + 1;
        end
    end
end

disp(A(pos + 1));
res = 0;

for j = 2 : n
    res = mod(res + mod(k, j), j);
end

disp(res + 1);