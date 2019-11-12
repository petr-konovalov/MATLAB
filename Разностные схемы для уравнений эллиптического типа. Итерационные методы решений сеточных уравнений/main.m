%Коновалова Петра Вариант 3

M = 5;
N = 3 * M;
eps = 1e-5;
lx = pi;
ly = 1;
hx = lx / N;
hy = ly / M;
hx2 = hx * hx;
hy2 = hy * hy;

U_ex = mU((0: N)' * hx, (0: M) * hy);
U_0 = zeros(N + 1, M + 1);
U_0(1: N + 1, 1) = mU((0: N) * hx , 0);
U_0(1: N + 1, M + 1) = mU((0: N) * hx, M * hy);
U_0(1, 2: M) = mU(0, (1: M - 1) * hy);
U_0(N + 1, 2: M) = mU(N  * hx, (1: M - 1) * hy);
fv = f((0:N)'*hx, (0:M)*hy);

d = (2*sin(pi*0.5/N)/hx)^2+(2*sin(pi*0.5/M)/hy)^2;
D = (2*cos(pi*0.5/N)/hx)^2+(2*cos(pi*0.5/M)/hy)^2;
xsi = d/D;
m = ceil(log(1/eps)*0.5/xsi);
ro = (1-xsi)/(1+xsi);
printResult("simpleIteration", N, M, U_0, U_ex, hx, hy, fv, m, ro);

m = ceil(log(1/eps)*0.25/xsi);
printResult("Seidel", N, M, U_0, U_ex, hx, hy, fv, m, ro * ro);

m = ceil(log(2/eps)/(2*sqrt(xsi)));
printResult("Chebyshev", N, M, U_0, U_ex, hx, hy, fv, m, ro, D, d);

D = 4 / hx2 + 4 / hy2;
eta = d / D;
omga = 2 / sqrt(d * D);
gma1 = d / (2 + 2 * sqrt(eta));
gma2 = d / (4 * sqrt(eta));
tau = 2 / (gma1 + gma2);
k1 = omga / (hx * hx);
k2 = omga / (hy * hy);
xsi = gma1 / gma2;
ro = (1 - xsi) / (1 + xsi);
m = ceil(log(eps) / log(ro));
printResult("altTriangularMethod", N, M, U_0, U_ex, hx, hy, fv, m, ro, k1, k2, tau);
