O = [0,  0];
rCnt = 6;
Q = zeros(rCnt, 2);
R = 2;
k = 4;

pnt = [random('Uniform', -90, 90), random('Uniform', -90, 90)];
for j = 1: rCnt
    Q(j, 1) = random('Uniform', -90, 90);
    Q(j, 2) = random('Uniform', -90, 90);
end

disp(pointAvailability(O, pnt, Q, R));
slowDefArea = getDefenceArea(O, Q, R, 4);
fastDefArea = getDefenceArea(O, Q, R, 1.5);
hold on;

plot(O(1), O(2), 'g*');

for j = 1: rCnt
    cir = slowDefArea(j, :);
    drawCircle(cir(1), cir(2), cir(3), 'r-', 1);
end

for j = 1: rCnt
    cir = fastDefArea(j, :);
    drawCircle(cir(1), cir(2), cir(3), 'g-', 1);
end

plot(pnt(1), pnt(2), 'y*');
for j = 1: rCnt
    plot(Q(j, 1), Q(j, 2), 'b.');
end
axis([-100 100 -100 100]);

hold off;