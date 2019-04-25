function [order, matr] = streightStepChoice(matr)
    order = initOrder(size(matr, 1));
    for k = 1: size(matr, 1)
        [p, q] = findMax(matr, k);
        [order(k), order(q)] = deal(order(q), order(k));
        for i = k: size(matr, 2)
            [matr(k, i), matr(p, i)] = deal(matr(p, i), matr(k, i));
        end
        for i = 1: size(matr, 1)
            [matr(i, k), matr(i, q)] = deal(matr(i, q), matr(i, k)); 
        end
        for i = k + 1: size(matr, 1)
            tmp = matr(i, k) / matr(k, k);
            for j = k: size(matr, 2)
                matr(i, j) = matr(i, j) - matr(k, j) * tmp;
            end
        end
    end
end

function [p, q] = findMax(matr, k)
    m = abs(matr(k, k));
    p = k;
    q = k;
    for i = k: size(matr, 1)
        for j = k: size(matr, 1)
            if abs(matr(i, j)) > m
                p = i;
                q = j;
                m = abs(matr(i, j));
            end
        end
    end
end

function order = initOrder(size)
    order = zeros(1, size);
    for i = 1: size
        order(i) = i;
    end
end
