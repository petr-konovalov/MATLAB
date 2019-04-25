function lagGraphic
x = 0: pi/100: 3*pi;

xk = [pi/4 pi/2 pi 2*pi 3*pi];
subplot(5, 2, 1);
plot(x, f(x), 'r-', x, calcLagrang(x, xk, f(xk)));
subplot(5, 2, 2);
plot(x, g(x), 'r-', x, calcLagrang(x, xk, g(xk)));

xk = [pi/6 pi/2 pi 5*pi/6 3*pi/2];
subplot(5, 2, 3);
plot(x, f(x), 'r-', x, calcLagrang(x, xk, f(xk)));
subplot(5, 2, 4);
plot(x, g(x), 'r-', x, calcLagrang(x, xk, g(xk)));

xk = [5*pi/3 2*pi 9*pi/4 5*pi/2 17*pi/6];
subplot(5, 2, 5);
plot(x, f(x), 'r-', x, calcLagrang(x, xk, f(xk)));
subplot(5, 2, 6);
plot(x, g(x), 'r-', x, calcLagrang(x, xk, g(xk)));

xk = [3*pi/4 pi 4*pi/3 11*pi/6 13*pi/6];
subplot(5, 2, 7);
plot(x, f(x), 'r-', x, calcLagrang(x, xk, f(xk)));
subplot(5, 2, 8);
plot(x, g(x), 'r-', x, calcLagrang(x, xk, g(xk)));

xk = [pi/4 pi/2 pi 7*pi/6 3*pi/2 7*pi/4 2*pi 7*pi/3 17*pi/6 3*pi];
subplot(5, 2, 9);
plot(x, f(x), 'r-', x, calcLagrang(x, xk, f(xk)));
subplot(5, 2, 10);
plot(x, g(x), 'r-', x, calcLagrang(x, xk, g(xk)));

function [y] = f(x)
y = sin(x / 3);
    
function [y] = g(x)
y = sin(10 * x);

function [res] = omegak(k, x, xk)
res = ones(1, length(x));
mask = ones(1, length(x));
for i = 1: k - 1
    res = res .* (x - mask * xk(i));
end
for i = k + 1: length(xk)
    res = res .* (x - mask * xk(i));
end

function [res] = derOmega(k, xk)
res = omegak(k, xk(k), xk);
 
function [res] = calcLagrang(x, xk, y)
res = zeros(1, length(x));
for i = 1: length(xk)
    res = res + y(i) * omegak(i, x, xk) / derOmega(i, xk);
end