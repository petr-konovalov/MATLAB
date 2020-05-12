frames = 100;
%[x, y] = meshgrid( [0:0.01:1] );
%[u, v] = meshgrid(-pi/2:pi/180:pi/2, 0:pi/180:2*pi);
R = 0.05;
t = linspace( 0, pi, frames);
for k =1:frames
    %z = sin(2*pi*x).*sin(3*pi*y).*sin(2*t(k));
    %x = R.*cos(u).*cos(v);
    %y = R.*cos(u).*sin(v);
    %z = R.*sin(v);
    [x, y, z] = sphere(30);
    x = R*x + 0.5;
    surf(x,R*y,R*z);
    [x, y, z] = sphere(30);
    surf(R*x,R*y,R*z);
    shading flat;
    axis( [-1 1 -1 1 -1 1]);
    colormap(bone); %или pink
    M(k) = getframe;
    hold on
end
movie(M,1,500)

