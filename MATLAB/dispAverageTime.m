function dispAverageTime(fileName, fileSize, curvBound, distBound)
    file = fopen(fileName, 'r');
    
    averFirst = 0;
    averSecond = 0;
    cntT2moreT1 = 0;
    cntT1moreT2 = 0;
    cnt = 0;
    
    for k = 1: fileSize
        inp = fscanf(file, '%i', [5]);
        if checkBound(inp(2), curvBound) && checkBound(inp(3), distBound)
            cnt = cnt + 1;
            averFirst = averFirst + inp(4);
            averSecond = averSecond + inp(5);
            if inp(4) > inp(5)
                cntT1moreT2 = cntT1moreT2 + 1;
            end
            if inp(5) > inp(4)
                cntT2moreT1 = cntT2moreT1 + 1;
            end
        end
    end
    averFirst = averFirst / cnt;
    averSecond = averSecond / cnt;
    
    fprintf('Количество: %i\n', cnt);
    fprintf('Среднее число шагов первого: %f\n', averFirst);
    fprintf('Среднее число шагов второго: %f\n', averSecond);
    fprintf('Вероятность T2>T1: %f\n', cntT2moreT1 / cnt);
    fprintf('Вероятность T1>T2: %f\n', cntT1moreT2 / cnt);
    
    fclose(file);
end

function res = checkBound(val, bound)
    res = bound(1) <= val && val <= bound(2);
end

    

