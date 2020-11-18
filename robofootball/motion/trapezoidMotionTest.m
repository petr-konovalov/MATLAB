T = 0:0.01:10;
trM = zeros(0, numel(T));
for k = 1:numel(T)
    trM(k) = trapezoidMotion(T(k), 5, 0.2, 1, 0.15);
end

plot(T, trM);