function [res] = getBackMatr(size, matr)
    res = zeros(size, 2 * size);
    for i = 1: size
        for j = 1: size
            res(i, j) = matr(i, j);
        end
    end
    for i = 1: size
        res(i, i + size) = 1;
    end
    
    res = streightStepSimple(res);
    for i = 1: size
       for j = i + 1: 2 * size
           res(i, j) = res(i, j) / res(i, i); 
       end
       res(i, i) = 1;
    end

    for i = size: -1: 2
        for j = 1: i - 1
            tmp = res(j, i);
            for k = i: 2 * size
               res(j, k) = res(j, k) - tmp * res(i, k);
            end
        end
    end
   
    res = res(1: size, size + 1: 2 * size);
end
