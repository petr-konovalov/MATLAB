global wLNearest wRNearest ort normir codot;
wl = @(t)[2*sin(t).*(1+0.1*cos(13*t)); 2*cos(t).*(1+0.1*sin(11*t))];
wr = @(t)[sin(t).*(1+0.1*cos(7*t)); cos(t).*(1+0.1*sin(5*t))];
codot = @(U, V)det([U'; V']);
wLNearest = @(X)wl(minSearch(@(s)norm(X-wl(s)), 0:pi/5000:2*pi));
wRNearest = @(X)wr(minSearch(@(s)norm(X-wr(s)), 0:pi/5000:2*pi));
ort = @(X)[X(2); -X(1)];
normir = @(X)X/norm(X);
%disp(f(0, [1;2]));
%f = @(t, X) normir(normir(ort(wLNearest(X)-X))-normir(ort(wRNearest(X)-X)));

N = 1000;

T = 0:2*pi/N:2*pi;
Xl = zeros(numel(T), 2);
Xr = zeros(numel(T), 2);
for k = 1:numel(T)
    Xl(k, :) = wl(T(k));
    Xr(k, :) = wr(T(k));
end
[t, expX] = ode15s(@(t, X)f(t, X), [0, 50], [0; 1.2]);
hold on;
plot(Xl(:, 1), Xl(:, 2));
plot(Xr(:, 1), Xr(:, 2));
plot(expX(:, 1), expX(:, 2));
%plot(Xn(:, 1), Xn(:, 2));
hold off;

function res = f(t, X)
    global wLNearest wRNearest ort normir codot;
    A = wLNearest(X);
    B = wRNearest(X);
    U = ort(A-X);
    V = ort(X-B);
    VxU = codot(V, U);
    if abs(VxU) < 0.000001
        res = normir(A+codot(B-A, U)/VxU*V-X);
    else
        res = normir((U+V)/2);
    end
end
