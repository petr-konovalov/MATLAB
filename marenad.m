infinity = 100000;
eps = 1e-3;
l = 1;
r = 1.2;
tt = 1;
cnt = 0;
tspan = [0 tt];
y0 = [0 1.10859128];
fun = @(t, X)([X(2); -X(1)-X(2)+X(2)^3]);
[t, Y] = ode45(fun, [0; 16], y0);
plot(Y(:, 1), Y(:, 2));
while (cnt < 10)
    m = (r+l)/2;
    if (r == m || l == m) %Stopping if reach machine precision
        break;
    end
    [t, Y] = ode45(fun, tspan, [0; m]);
    Ylen = numel(Y)/2;
    if norm(Y(Ylen, :)) > infinity
        r = m;
    elseif norm(Y(Ylen, :)) < eps
        l = m;
    else
        tt = tt*2;
        cnt = cnt + 1;
        tspan = [0 tt];
    end
    fprintf("%d %f %.55f\n", cnt, norm(Y(Ylen, :)), m);
end
[t, Y] = ode45(fun, tspan, [0; l]);

figure();
plot(Y(:, 1), Y(:, 2));