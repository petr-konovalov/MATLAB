hold on;

S = [-100, 0];
F = [100, 0];
%obst = [-5, 1, 1; -3, -1, 1; 1, 0, 1; 1 4 1; 3 1 1; 7 -1 1];

oCnt = 80;
oR = 7;
obst = zeros(oCnt, 3);
for j = 1: oCnt
    obst(j, 1) = random('Uniform', -90, 90);
    obst(j, 2) = random('Uniform', -90, 90);
    obst(j, 3) = oR;
end

step = -2;

pathUP = fastBuildPath(S, F, obst, step, 1);
pathDOWN = fastBuildPath(S, F, obst, -step, 1);

pathUP = pathOptimize(pathUP, obst);
xUP = zeros(1, pathUP.size());
yUP = zeros(1, pathUP.size());
for k = 1: numel(xUP)
    tmp = pathUP.pop();
    xUP(k) = tmp(1);
    yUP(k) = tmp(2);
end

% for k = 1: numel(xUP)
%     pathUP.add([xUP(k), yUP(k)]);
% end
% 
% nPntUP = getNextPointOnPath(pathUP, obst);

pathDOWN = pathOptimize(pathDOWN, obst);
xDOWN = zeros(1, pathDOWN.size());
yDOWN = zeros(1, pathDOWN.size());
for k = 1: numel(xDOWN)
    tmp = pathDOWN.pop();
    xDOWN(k) = tmp(1);
    yDOWN(k) = tmp(2);
end

% for k = 1: numel(xDOWN)
%     pathDOWN.add([xDOWN(k), yDOWN(k)]);
% end
% 
% nPntDOWN = getNextPointOnPath(pathDOWN, obst);

plot(xUP, yUP, '-g', 'linewidth', 3);
plot(xDOWN, yDOWN, 'linewidth', 3);
for k = 1: size(obst, 1)
    drawCircle(obst(k, 1), obst(k, 2), obst(k, 3), '-r', 3);
end
%plot(nPntUP(1), nPntUP(2), 'g*');
%plot(nPntDOWN(1), nPntDOWN(2), 'g*');
axis([-100 100 -100 100]);

hold off;