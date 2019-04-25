function drawCircle(x, y, r, lineType, lineWidth)
    cnt = 100;
    step = 2 * pi / cnt;
    X = zeros(cnt + 1);
    Y = zeros(cnt + 1);
    for k = 1: cnt + 1
        X(k) = x + r * cos(step * k);
        Y(k) = y + r * sin(step * k);
    end
    plot(X, Y, lineType, 'linewidth', lineWidth);
end

