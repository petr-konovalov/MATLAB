function res = checkSystem(A, B, C, flag)
    if nargin < 4
        flag = true;
    end
    res = true;
    if ~isControlable(A, B)
        if flag
            disp('Система не управляема.')
        end
        res = false;
    end
    if ~isControlable(A, C')
        if flag 
            disp('Система не наблюдаема.')
        end
        res = false;
    end
end

