n = 1000;
xnn = zeros(1, n);
x = zeros(1, n);
y = zeros(1, n);
v = zeros(1, n);
dt = 0.02;
a = 200;
vmax = 1000;
sigy = 20/3;
sigu = 50/3;
Plant = ss(1, dt, 1, 0, -1);
R = sigy^2;
Q = sigu^2;
[~,~,~,M] = kalman(Plant,Q,R);
xnn(1) = 0;
for k = 2: n-vmax/(a*dt)
    %Prediction
    xn1n = xnn(k-1)+dt*v(k-1);
    
    x(k) = x(k-1)+dt*(v(k-1)+normrnd(0, sigu));
    y(k) = x(k) + normrnd(0, sigy);
    v(k) = min(v(k-1)+a*dt, vmax);
    
    %Correction
    xnn(k) = xn1n + M * (y(k)-xn1n);
end
for k = n-vmax/(a*dt)+1: n
    %Prediction
    xn1n = xnn(k-1)+dt*v(k-1);
    
    x(k) = x(k-1)+dt*(v(k-1)+normrnd(0, sigu));
    y(k) = x(k) + normrnd(0, sigy);
    v(k) = v(k-1)-a*dt;
    
    %Correction
    xnn(k) = xn1n + M * (y(k)-xn1n);
end

hold on;
plot(1:n, y-x, '--');
plot(1:n, xnn-x);
hold off;