R = 1.1;
G = @(s)(s^2-1)/((s+1)*(s*s+1));
tr = @(t)(sign(-pi/2 <= t && t <= pi/2)*(cos(t)-i*sin(t))+...
          sign(t > pi/2)*(i*(2*t/pi-2)));

T = -pi/2:pi/123:10.215446*pi/7;
ipnts = zeros(1, numel(T));
%hold on;
%for R = 0+0.01:0.2:3+0.01
for k = 1:numel(T)
    %ipnts(k) = G(R*tr(T(k)));
    ipnts(k) = G(R*tr(T(k)));
end

plot(real(ipnts), imag(ipnts));
%end
%hold off;