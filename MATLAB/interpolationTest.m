[X,Y] = meshgrid(-3:3);
V = peaks(X,Y);
[Xq,Yq] = meshgrid(-3:0.25:3);
Vq = interp2(X,Y,V,Xq,Yq);
figure;
surf(Xq,Yq,Vq);
title('Linear Interpolation Using Finer Grid');