function Demidovich2938()
    args = -3:0.001:3;
    hold on;
    plot(args, partSum(args, 10));
    plot(args, partSum(args, 100));
    plot(args, partSum(args, 1000));
    hold off;
end

function [res] = partSum(x, n)
    res = 0;
    for k = 0: n
        res = res + sin((2 * k + 1) * x) / (2 * k + 1);
    end
    res = res * 4 / pi;
end

