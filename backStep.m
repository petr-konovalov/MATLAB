function matr = backStep(matr)
    for i = size(matr, 1): -1: 1
        for j = i + 1: size(matr, 1)
            matr(i, size(matr, 2)) = matr(i, size(matr, 2)) - matr(j, size(matr, 2)) * matr(i, j);
        end
        matr(i, size(matr, 2)) = matr(i, size(matr, 2)) / matr(i, i);
    end
end

