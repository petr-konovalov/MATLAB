function [matr] = streightStepSimple(matr)
    eps = 1e-6;
    for k = 1: size(matr, 1)
        if abs(matr(k, k)) < eps
            fprintf('Внимание! Малое значение на стадии: %d\n', k)
        end
        for i = k + 1: size(matr, 1)
            tmp = matr(i, k) / matr(k, k);
            for j = k: size(matr, 2)
                matr(i, j) = matr(i, j) - matr(k, j) * tmp;
            end
        end
    end
end

