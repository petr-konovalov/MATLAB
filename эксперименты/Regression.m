cnt = 1000000;
k = 0.01;
w = -73;
pX = 100 * rand(1, cnt);
pY = k * pX + w + 10*(rand(1, cnt)-0.5);
%for j = 1: cnt
%    plot(pX, pY, '*');
%    hold on;
%end

EX = sum(pX) / cnt;
EY = sum(pY) / cnt;
DX = (pX-EX)*(pX-EX)'/cnt;
DY = (pY-EY)*(pY-EY)'/cnt;
covXY = (pX-EX)*(pY-EY)'/cnt;
a = (DY-DX)/(2*covXY);
D = sqrt(1+a*a);

c1 = a - D;
p1 = c1 * EY + EX;
f1 = (c1*pY+pX-p1)*(c1*pY+pX-p1)';
c2 = a + D;
p2 = c2 * EY + EX;
f2 = (c2*pY+pX-p2)*(c2*pY+pX-p2)';
disp([-1/c1, p1/c1, f1/100000000]);
disp([-1/c2, p2/c2, f2/100000000]);
if f1 < f2
    c = c1;
    p = p1;
else
    c = c2;
    p = p2;
end
disp([-1/c, p/c]);