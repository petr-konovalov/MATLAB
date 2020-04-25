global M m l R J g A B C a L RR M_ T HCoef Theta0 dTheta0 w0 version;
version = 0;
M = 1;
m = 0.1;
l = 0.9;
R = 0.2;
Theta0 = 45*pi/180;
dTheta0 = 0;
J = (M*R*R)/2;
g = 9.8;
L = 2;

C = 3*J;
A = C+m*R*R;
B = m*R*l;
a = L*sin(Theta0);
w0 = a/R;

N = 120;
M_= 7;
T = 2*pi;
Q = [0.1 0 0; 0 0.1 0; 0 0 1];
RR = 0.3;
%Рассчёт HCoef через LMI
HCoef = getHCoef(Q, RR, N, M_, T);

%Инициализирует HCoef заранее подсчитанными значениями
%setHCoef;