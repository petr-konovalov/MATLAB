wl = @(t)[2*sin(t).*(1+0.1*cos(13*t)); 2*cos(t).*(1+0.1*sin(11*t))];
wr = @(t)[sin(t).*(1+0.1*cos(7*t)); cos(t).*(1+0.1*sin(5*t))];
wLNearest = @(X)wl(minSearch(@(s)norm(X-wl(s)), 0:pi/1000:2*pi));
wRNearest = @(X)wr(minSearch(@(s)norm(X-wr(s)), 0:pi/1000:2*pi));
ort = @(X)[X(2); -X(1)];
normir = @(X)X/norm(X);
f = @(t, X) normir(normir(ort(wLNearest(X)-X))-normir(ort(wRNearest(X)-X)));

N = 1000;

T = 0:2*pi/N:2*pi;
Xl = zeros(numel(T), 2);
Xr = zeros(numel(T), 2);
for k = 1:numel(T)
    Xl(k, :) = wl(T(k));
    Xr(k, :) = wr(T(k));
end
[t, expX] = ode45(f, [0, 100], [0, 1.2]);
hold on;
plot(Xl(:, 1), Xl(:, 2));
plot(Xr(:, 1), Xr(:, 2));
plot(expX(:, 1), expX(:, 2));
%plot(Xn(:, 1), Xn(:, 2));
hold off;
