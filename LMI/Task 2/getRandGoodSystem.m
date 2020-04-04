function [A, B, C] = getRandGoodSystem(n, m, l, itBound)
    if nargin < 4
        itBound = 15;
    end
    A = rand(n);
    B = rand(n, m);
    C = rand(l, n);
    it = 1;
    while ~checkSystem(A, B, C, false) && it < itBound
        A = rand(n);
        B = rand(n, m);
        C = rand(l, n);
        it = it + 1;
    end
    if ~checkSystem(A, B, C, false)
        disp('Generation fail')
    end
end