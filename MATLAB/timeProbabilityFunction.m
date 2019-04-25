function timeProbabilityFunction(fileName, fileSize, minComplexity, maxComplexity)
    file = fopen(fileName, 'r');
    firstTime = zeros(fileSize, 1);
    secondTime = zeros(fileSize, 1);
    averageFirst = 0;
    averageSecond = 0;
    averageSqrFirst = 0;
    averageSqrSecond = 0;
    averageTimeFrac12 = 0;
    averageTimeFrac21 = 0;
    averageSqrTimeFrac12 = 0;
    averageSqrTimeFrac21 = 0;
    cntT2moreT1 = 0;
    cntT1moreT2 = 0;
    cntT1equalT2 = 0;
    cnt = 0;
    for k = 1: fileSize
        inp = fscanf(file, '%i', [5]);
        if (inp(4) < minComplexity || maxComplexity < inp(4))
            continue;
        end
        cnt = cnt + 1;
        inp(1) = inp(1) / 1000000;
        inp(2) = inp(2) / 1000000;
        firstTime(k) = inp(1);
        secondTime(k) = inp(2);
        averageFirst = averageFirst + inp(1);
        averageSecond = averageSecond + inp(2);
        averageSqrFirst = averageSqrFirst + inp(1) ^ 2;
        averageSqrSecond = averageSqrSecond + inp(2) ^ 2;
        if (inp(1) > inp(2))
            cntT1moreT2 = cntT1moreT2 + 1;
            averageTimeFrac12 = averageTimeFrac12 + inp(1) / inp(2);
            averageSqrTimeFrac12 = averageSqrTimeFrac12 + (inp(1) / inp(2)) ^ 2;
        end
        if (inp(2) > inp(1))
            cntT2moreT1 = cntT2moreT1 + 1;
            averageTimeFrac21 = averageTimeFrac21 + inp(2) / inp(1);
            averageSqrTimeFrac21 = averageSqrTimeFrac21 + (inp(2) / inp(1)) ^ 2;
        end
    end
    fclose(file);
    averageFirst = averageFirst / cnt;
    averageSecond = averageSecond / cnt;
    averageSqrFirst = averageSqrFirst / cnt;
    averageSqrSecond = averageSqrSecond / cnt;
    averageTimeFrac12 = averageTimeFrac12 / cntT1moreT2;
    averageTimeFrac21 = averageTimeFrac21 / cntT2moreT1;
    averageSqrTimeFrac12 = averageSqrTimeFrac12 / cntT1moreT2;
    averageSqrTimeFrac21 = averageSqrTimeFrac21 / cntT2moreT1;
    
    fprintf('Отрезок сложностей: [%d; %d]\n', minComplexity, maxComplexity);
    fprintf('Число сцен выбранной сложности: %d\n', cnt);
    fprintf('Среднее число шагов первого алгоритма: %f\n', averageFirst);
    fprintf('Среднее число шагов второго алгоритма: %f\n', averageSecond);
    fprintf('Дисперсия времени работы первого алгоритма: %f\n', averageSqrFirst - averageFirst ^ 2);
    fprintf('Дисперсия времени работы второго алгоритма: %f\n', averageSqrSecond - averageSecond ^ 2);
    fprintf('Соотношение между средним числом шагов: %f\n', averageSecond / averageFirst);
    fprintf('Мат. ожидание дроби T2/T1 при T2>T1: %f\n', averageTimeFrac21);
    fprintf('Мат. ожидание дроби T1/T2 при T1>T2: %f\n', averageTimeFrac12);
    fprintf('Дисперсия дроби T2/T1 при T2>T1: %f\n', averageSqrTimeFrac12 - averageTimeFrac12 ^ 2);
    fprintf('Дисперсия дроби T1/T2 при T1>T2: %f\n', averageSqrTimeFrac21 - averageTimeFrac21 ^ 2);
    fprintf('Вероятность T2>T1: %f\n', cntT2moreT1 / cnt);
    fprintf('Вероятность T1>T2: %f\n', cntT1moreT2 / cnt);
    fprintf('\n\n');
    
    %{
    eps = 0.5;
    maxK = 100;
    result = zeros(maxK, 1);
    for k = 1: maxK
        for j = 1: cnt
            tmp = firstTime(j) / secondTime(j);
            if (tmp < k * eps)
                result(k) = result(k) + 1;
            end
        end
    end
    plot(result, '.');
    
    result = zeros(maxK, 1);
    for k = 1: maxK
        for j = 1: cnt
            tmp = secondTime(j) / firstTime(j);
            if (tmp < k * eps)
                result(k) = result(k) + 1;
            end
        end
    end
    hold on;
    plot(result, 'r.');
    %}
end
