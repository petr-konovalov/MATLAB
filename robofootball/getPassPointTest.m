O = [-100,  0];
rCnt = 3;
Q = zeros(rCnt, 2);
R = 4;
k = 2;
aR = 30;
aCenter = [random('Uniform', -90, 90), random('Uniform', -90, 90)];
pCnt = 1000;

for j = 1: rCnt
    Q(j, 1) = random('Uniform', -90, 90);
    Q(j, 2) = random('Uniform', -90, 90);
end

A = [80,  40];
B = [80, -40];

% cnt = 100000;
% t = 0: 1/cnt: 1;
% y = zeros(1, cnt + 1);
% 
% for j = 1: cnt + 1
%     dir = A * (1 - t(j)) + B * t(j) - O;
%     dir = dir / norm(dir);
%     y(j) = attackDirectQuality(dir, O, Q, R, k);
% end
% 
% plot(t, y);

%figure;

hold on;

plot(O(1), O(2), 'g*');
plot([A(1), B(1)], [A(2), B(2)], 'b');

for j = 1: rCnt
    drawCircle(Q(j, 1), Q(j, 2), R, 'r-', 3);
end
axis([-100 100 -100 100]);
drawCircle(aCenter(1), aCenter(2), aR, 'y', 1);

passPnt = getPassPoint(A, B, O, Q, R, k, aR, aCenter, pCnt);
if passPnt ~= [-100000, -100000]
    plot(passPnt(1), passPnt(2), 'g*');
end
disp(passPnt);

hold off;