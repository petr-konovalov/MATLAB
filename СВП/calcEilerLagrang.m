global dq1 dq2 q1 q2 M B;
syms t q1(t) q2(t);

l1 = 5;
l2 = 3;
r1 = 2;
r2 = 1;
G  = 0.00098;
m1 = 3;
m2 = 1;

dq1 = diff(q1, t);
dq2 = diff(q2, t);
ddq1 = diff(dq1, t);
ddq2 = diff(dq2, t);
x1 = l1 * cos(q1);
y1 = l1 * sin(q1);
x2 = (l1 + l2 - q2) * cos(q1);
y2 = (l1 + l2 - q2) * sin(q1);
xm1 = r1 * cos(q1);
ym1 = r1 * sin(q1);
xm2 = (l1 + r2 - q2) * cos(q1);
ym2 = (l1 + r2 - q2) * sin(q1);

dxm1 = diff(xm1, t);
dym1 = diff(ym1, t);
dxm2 = diff(xm2, t);
dym2 = diff(ym2, t);

T = 1/2*m1*(dxm1+dym1)^2+1/2*m2*(dxm2+dym2)^2;
P = m1*G*ym1+m2*G*ym2;
L = simplify(T - P);
dLdq1 = pDiff(L, q1);
dLdq2 = pDiff(L, q2);
dLddq1 = pDiff(L, dq1);
dLddq2 = pDiff(L, dq2);

EilLag = [diff(dLddq1, t) - dLdq1; diff(dLddq2, t) - dLdq2];

M = [pDiff([1, 0] * EilLag, ddq1), pDiff([1, 0] * EilLag, ddq2); pDiff([0, 1] * EilLag, ddq1), pDiff([0, 1] * EilLag, ddq2)];
B = simplify(EilLag - M * [ddq1; ddq2]);
g = simplify(subs(B, [dq1, dq2], [0, 0]));