function orthogonalRegression(fileName, cnt)
    clc;
    file = fopen(fileName, 'r');
    data = zeros(cnt, 1);
    for k = 1: cnt
        inp = fscanf(file, '%i', [3]);
        data(k) = inp(1) + inp(2) * 1i;
    end
    fclose(file);
    
    figure(1);
    draw(data);
    %{
    for k = 1: 5
        figure(k + 1);
        draw(data(1 + 200 * (k - 1): 200 * k));
    end
    %}
end

function draw(data)
    cnt = size(data, 1);
    C = 0;
    for k = 1: cnt
        C = C + data(k);
    end
    C = C / cnt;
    Z = 0;
    for k = 1: cnt
        Z = Z + (data(k) - C) ^ 2;
    end
    Z = Z / abs(Z);
    plot([C - 1500000 * Z, C + 100000 * Z], 'r-');
    hold on;
    plot(data, '.');
end