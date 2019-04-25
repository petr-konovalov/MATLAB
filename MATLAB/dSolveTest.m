A = [-125 123.05; 123.05 -123];
initData = [1 1];
syms y1(t) y2(t);
eqn1 = diff(y1, 1) == A(1, 1) * y1 + A(1, 2) * y2;
eqn2 = diff(y2, 1) == A(2, 1) * y1 + A(2, 2) * y2;
cond = [y1(0) == initData(1), y2(0) == initData(2)];
dsolve(eqn1, eqn2, cond);