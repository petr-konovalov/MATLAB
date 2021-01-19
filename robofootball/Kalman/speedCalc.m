N = size(RData1);
N = N(1);
dT = 0.05;
Speeds = zeros(N, 7);
prev = 1;
sIt = 0;
for k = 2:N
    if RData1(k, 1)-RData1(prev, 1) > dT
        sIt = sIt+1;
        Speeds(sIt, 1:3) = (RData1(k, 3:5)-RData1(prev, 3:5))/(RData1(k, 1)-RData1(prev, 1));
        ux = RData1(k, 6);
        uy = RData1(k, 7);
        uTh = RData1(k, 8);
        sTh = sin(uTh);
        cTh = cos(uTh);
        Speeds(sIt, 4:6) = [ux*cTh+uy*sTh, -ux*sTh+uy*cTh, uTh];
        Speeds(k, 7) = RData1(k, 1);
        prev = k;
    end
end
Speeds = Speeds(1:sIt, :);
hold on;
plot(cumsum(Speeds(1:600, 7)), Speeds(1:600, 1)/10);
plot(cumsum(Speeds(1:600, 7)), Speeds(1:600, 4));
hold off;