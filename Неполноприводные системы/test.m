global M m l R J g A B C a L RR M_ T HCoef Theta0 dTheta0 w0 stp FStepX version;
version = 1;
M = 1;
m = 0.1;
l = 0.5;
R = 0.1;
Theta0 = 0;
dTheta0 = 3.1;
J = (M*R*R)/2;
g = 9.8;
L = 1;

C = 3*J;
A = C+m*R*R;
B = m*R*l;
a = L*sin(Theta0);
w0 = a/R;

N = 120;
M_= 7;
Q = [0.1 0 0; 0 0.1 0; 0 0 1];
RR = 0.001;

%Рассчёт решения абг уравнения и его периода
TStart = 0;
TFinish = 5;
stp = 0.005;
[gt, gX] = solveSsEq(Theta0, dTheta0, TStart, TFinish);
FStepX = difTStepToFixTStep(stp, gt, gX);
plot(gt, gX);
T = linSearchGFValArg(0, TStart+0.1, TFinish, gt, gX(:, 1));
T = T(2);

%Рассчёт HCoef через LMI
HCoef = getHCoef(Q, RR, N, M_, T);

