function [res, matr] = solveChoice(matr)
    [order, matr] = streightStepChoice(matr);
    res = backStepChoice(order, matr);
end
    
function res = backStepChoice(order, matr)
    matr = backStep(matr);
    res = zeros(size(matr, 1), 1);
    for i = 1: size(matr, 1)
        res(order(i)) = matr(i, size(matr, 2));
    end
end
