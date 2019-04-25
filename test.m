%{
import java.util.LinkedList
q = LinkedList();
q.add(15);
q.add(12);
disp(q.pop());
disp(q.pop());
%}
%алгоритм предполагает что шаг меньше чем минимальный радиус окрестности
pos = [30 50];
aim = [70 -30];
obst = [-60, 30, 20; -30, 20, 8; -50, -10, 10; -10, -5, 15; 10, 20, 20; 30, -25, 15; 60, 30, 34; 70, -10, 10];
left = -80;
right = 100;
down = -40;
up = 60;
verStep = 5;
horStep = 5;

path = buildPath(obst, pos, aim, left, right, down, up, verStep, horStep);
x = zeros(size(path, 1));
y = zeros(size(path, 1));
for k = 1: size(path, 1)
    x(k) = path(k, 1);
    y(k) = path(k, 2);
end

hold on;

l = floor((pos(1) - left) / verStep);
r = floor((right - pos(1)) / verStep);
d = floor((pos(2) - down) / horStep);
u = floor((up - pos(2)) / horStep);
for px = -l: r
    for py = -d: u
        plot(pos(1) + verStep * px, pos(2) + horStep * py, 'g.');
    end
end

plot(x, y, 'linewidth', 3);
for k = 1: size(obst, 1)
    drawCircle(obst(k, 1), obst(k, 2), obst(k, 3));
end

hold off;