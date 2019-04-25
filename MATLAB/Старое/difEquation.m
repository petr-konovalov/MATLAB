function difEquation
    h = 0.1;
    [xE1, yE1] = Eiler(10);
    [xE2, yE2] = Eiler(20);
    [xE3, yE3] = Eiler(5);
    [xRK, yRK] = RungeKutt(h, 10);
    xAD = zeros(11);
    yAD = zeros(11);
    
    df = zeros(11, 11);
    for i = 1: 5
        df(1, i) = h*f(xRK(i), yRK(i));
        j = i - 1;
        k = 2;
        while j > 0
           df(k, j) = df(k - 1, j + 1) - df(k - 1, j); 
           j = j - 1;
           k = k + 1;
        end
        xAD(i) = xRK(i);
        yAD(i) = yRK(i);
    end
    for i = 5: 10
        xAD(i + 1) = xRK(i + 1);
        yAD(i + 1) = yAD(i)+df(1, i)+df(2, i-1)/2+df(3, i-2)*5/12+df(4, i-3)*3/8+df(5, i-4)*251/720;
        df(1, i + 1) = h*f(xAD(i + 1), yAD(i + 1));
        j = i;
        k = 2;
        while j > 0
           df(k, j) = df(k - 1, j + 1) - df(k - 1, j); 
           j = j - 1;
           k = k + 1;
        end
    end
    
    fprintf('Ýיכונ ןנט h = 0.1:\n');
    fprintf('%10s%10s%10s%10s\n', 'xk   ', 'yk   ', 'yk-y(xk)', 'A   ');
    for i = 1: 11
        fprintf('%10.6f%10.6f%10.6f%10.6f\n', xE1(i), yE1(i), yE1(i) - yAD(i), A(xE1(i)));
    end
    fprintf('\n');
    fprintf('Ýיכונ ןנט h = 0.05:\n');
    fprintf('%10s%10s\n', 'xk   ', 'yk   ');
    for i = 1: 21
        fprintf('%10.6f%10.6f\n', xE2(i), yE2(i));
    end
    fprintf('\n');
    fprintf('Ýיכונ ןנט h = 0.2:\n');
    fprintf('%10s%10s\n', 'xk   ', 'yk   ');
    for i = 1: 6
        fprintf('%10.6f%10.6f\n', xE3(i), yE3(i));
    end
    fprintf('\n');
    printDiff(xAD, yAD, df);

    plot(xRK, yRK, 'c-', xAD, yAD, 'm-', xE1, yE1, 'y-', xE2, yE2, 'g-', xE3, yE3, 'b-');
end

function [x, y] = RungeKutt(h, K)
    x = zeros(11);
    y = zeros(11);
    for k = 1: K
        x(k+1) = x(k)+h;
        k1 = h*f(x(k), y(k));
        k2 = h*f(x(k)+h/2, y(k)+k1/2);
        k3 = h*f(x(k)+h/2, y(k)+k2/2);
        k4 = h*f(x(k)+h, y(k)+k3);
        y(k+1) = y(k)+(k1+2*(k2+k3)+k4)/6;
    end
end

function [x, y] = Eiler(K)
    h = 1 / K;
    x = zeros(K + 1);
    y = zeros(K + 1);
    for k = 1: K
        x(k+1) = x(k)+h;
        y(k+1) = y(k)+h*f(x(k), y(k));
    end
end

function [res] = f(x, y)
    res = 1 - x + y * y;
end

function [res] = A(x)
    q = 0.686994;
    M1 = 1+q*q;
    M2 = 1;
    M3 = 2*q;
    M4 = M2+M1*M3;
    res = 0.1*exp(M3*x)*M4/(2*M3);
end

function printDiff(x, y, diff)
    fprintf('____________________________________________________________________________\n');
    fprintf('          |          |          |          |          |          |          |\n');
    fprintf('%10s|%10s|%10s|%10s|%10s|%10s|%10s|\n', 'x   ', 'y   ', 'f(x,y) ', 'd1  ', 'd2  ', 'd3  ', 'd4  ');
    fprintf('__________|__________|__________|__________|__________|__________|__________|\n');
    fprintf('          |          |          |          |          |          |          |\n');
    for i = 0: 20
        j = rem(i, 2);
        k = fix(i/2);
        if (j == 1)
            fprintf('%10s|%10s|%10s|', '', '', '');
        else
            fprintf('%10.6f|%10.6f|', x(k + 1), y(k + 1));
        end
        while j < 5
            if (k >= 0 && k < 11 - j)
                if (j < 4)
                    fprintf('%10.6f|%10s|', diff(j + 1, k + 1), ' ');
                else
                    fprintf('%10.6f|%10s', diff(j + 1, k + 1), ' ');
                end
            else
                if (j < 4)
                    fprintf('%10s|%10s|', '', '');
                else
                    fprintf('%10s|%10s', '', '');
                end
            end
            j = j + 2;
            k = k - 1;
        end
        fprintf('\n');
    end
    fprintf('__________|__________|__________|__________|__________|__________|__________|\n');
end
