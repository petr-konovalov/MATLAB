%clear all;
%BFAD = minMaxEdgeBFAD([0 0; 5 0; 10 0; 15 0], [0 3; 15 3; 10 3; 5 3]);  
%BFAD = minMaxEdgeBFAD([6 0; 7 0; 0 0; 4 0], [1 0; 2 0; 3 0; 5 0]);
pntCnt = 20;
startPos = zeros(pntCnt, 2);
aimPos = zeros(pntCnt, 2);
l = -100;
r = 100;
u = 100;
d = -100;

for k = 1: pntCnt
    startPos(k, 1) = rand(1) * (r - l) + l;
    startPos(k, 2) = rand(1) * (u - d) + d;
    aimPos(k, 1) = rand(1) * (r - l) + l;
    aimPos(k, 2) = rand(1) * (u - d) + d;
end
MAD = matchingAD(startPos, aimPos);
dis = MAD.getDistribution;

hold on;
    axis([l, r, d, u]);
    for k = 1: pntCnt
        plot([startPos(k, 1), aimPos(dis(k), 1)], [startPos(k, 2), aimPos(dis(k), 2)], 'b--');
    end
    for k = 1: pntCnt
        plot(startPos(k, 1), startPos(k, 2), '*g');
        plot(aimPos(k, 1), aimPos(k, 2), '*r');
    end
hold off;

