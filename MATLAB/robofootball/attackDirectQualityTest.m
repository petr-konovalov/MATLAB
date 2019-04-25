O = [-30,  0];
rCnt = 4;
Q = zeros(rCnt, 2);
R = 7;
k = 2;

for j = 1: rCnt
    Q(j, 1) = random('Uniform', -70, 10);
    Q(j, 2) = random('Uniform', -40, 40);
end

A = [15,  40];
B = [15, -40];

cnt = 100000;
t = 0: 1/cnt: 1;
y = zeros(1, cnt + 1);

for j = 1: cnt + 1
    dir = A * (1 - t(j)) + B * t(j) - O;
    dir = dir / norm(dir);
    y(j) = attackDirectQuality(dir, O, Q, R, k);
end

plot(t, y);

figure;
hold on;

plot(O(1), O(2), 'g*');
plot([A(1), B(1)], [A(2), B(2)], 'b');
lCnt = 10;
v = (B - A) / lCnt;

for j = 0: lCnt
    P = A + j * v;
    plot([O(1), P(1)], [O(2), P(2)], 'm:')
end

for j = 1: rCnt
    drawCircle(Q(j, 1), Q(j, 2), R, 'r-', 3);
end
axis([-50 50 -50 50]);

optDir = getOptimalDirect(A, B, O, Q, R, k);
plot([O(1), O(1) + optDir(1) * 100], [O(2), O(2) + optDir(2) * 100], 'r');

hold off;