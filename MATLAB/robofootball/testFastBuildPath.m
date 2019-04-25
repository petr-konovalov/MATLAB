hold on;

S = [-10, 0];
F = [10, 0];
obst = [-5, 1, 1; -3, -1, 1; 1, 0, 1; 1 4 1; 3 1 1; 7 -1 1];
step = -0.4;

pathUP = fastBuildPath(S, F, obst, step, 1);
pathDOWN = fastBuildPath(S, F, obst, -step, 1);
xUP = zeros(1, pathUP.size());
yUP = zeros(1, pathUP.size());

xDOWN = zeros(1, pathDOWN.size());
yDOWN = zeros(1, pathDOWN.size());

for k = 1: numel(xUP)
    tmp = pathUP.pop();
    xUP(k) = tmp(1);
    yUP(k) = tmp(2);
end

for k = 1: numel(xDOWN)
    tmp = pathDOWN.pop();
    xDOWN(k) = tmp(1);
    yDOWN(k) = tmp(2);
end

plot(xUP, yUP, 'linewidth', 3);
plot(xDOWN, yDOWN, 'linewidth', 3);
for k = 1: size(obst, 1)
    drawCircle(obst(k, 1), obst(k, 2), obst(k, 3), '-r', 3);
end

hold off;