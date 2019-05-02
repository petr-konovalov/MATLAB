A = [40, 20];
B = [40, -20];

O = [random('Uniform', -20, 35), random('Uniform', -50, 50)];
Q = [random('Uniform', -40, 25), random('Uniform', -50, 50)];
defPnt = getDefencePnt(A, B, O, Q, 1.3);

hold on;
plot([A(1), B(1)], [A(2), B(2)], 'b');
plot(Q(1), Q(2), 'r*');
plot(O(1), O(2), 'g*');
plot(defPnt(1), defPnt(2), 'm*');

axis([-50 50 -50 50]);
hold off;