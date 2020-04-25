% eps = 1e-5;
% th0 = 0;
% dth0 = 1.5;
% dTh = zeros(1, size(t, 1));
% for j = 1: size(t, 1)
%     dTh(j) = getDTheta(0, th(j), 0, 2.5, L, l, g);
%     disp(dTh(j));
%     %disp(dTh^2-((l-L*cos(th0)^2)/(l-L*cos(theta)^2))^(1/L)*dth0^2+...
%         %2*g*integral(@(s)sin(s)./(L*cos(s).^2-l).*abs((l-L*cos(s).^2)/(l-L*cos(theta).^2)).^(1/L), th0, theta));
% end

