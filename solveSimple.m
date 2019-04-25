function [res, matr] = solveSimple(matr)
    matr = streightStepSimple(matr);
    res = backStepSimple(matr);
end

function res = backStepSimple(matr)
    matr = backStep(matr);
    res = zeros(size(matr, 1), 1);
    for i = 1: size(matr, 1)
        res(i) = matr(i, size(matr, 2));
    end
end