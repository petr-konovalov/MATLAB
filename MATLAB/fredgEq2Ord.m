fprintf("Коновалов Пётр вариант 5\n-----------------------------------------------------\n");

syms x y;
H = 0.6/(3 + x * y^2);
f = x - 0.6;
H4 = taylor(H, [x, y], [0, 0], 'Order', 10);

disp(H4);

%ручками задаю alp и bet
alp = [1, x, x.^2, x.^3];
bet = [1/5, -y.^2/15, y.^4/45, -y.^6/135];

%проверка
disp(alp * bet.');

A = eye(4);
B = zeros(4, 1);

for i = 1: 4
    for j = 1: 4
        A(i, j) = A(i, j) - int(bet(i) * subs(alp(j), x, y), 0, 1);
    end
    B(i) = int(bet(i) * subs(f, x, y), 0, 1);
end

D3 = inv(A(1:3, 1:3));
G = alp(1:3) * D3 * bet(1:3).';
C3 = D3 * B(1:3);
C4 = A \ B;

u3 = f + alp(1:3) * C3;
u4 = f + alp * C4;

fprintf("%20s%10s%10s%10s\n", 'x', '0', '1/2', '1');
fprintf("%20s%10f%10f%10f\n", 'u3(x)', double(subs(u3, x, 0)), double(subs(u3, x, 1/2)), double(subs(u3, x, 1)));
fprintf("%20s%10f%10f%10f\n", 'u4(x)', double(subs(u4, x, 0)), double(subs(u4, x, 1/2)), double(subs(u4, x, 1)));
fprintf("%20s%10f%10f%10f\n", 'Оценка', double(subs(abs(u3 - u4), x, 0)), double(subs(abs(u3 - u4), x, 1/2)), double(subs(abs(u3 - u4), x, 1)));
fprintf("%20s%10f\n", 'Норма разности', getCNorm(@(t)double(subs(u3 - u4, x, t)), 0, 1));

drawFun(@(t)double(subs(abs(u3 - u4), x, t)), 0, 1, 0.01);

%вычисление оценки погрешности
BTil = getCNorm(@(t)integY(abs(G), x, y, t), 0, 1);
H3 = alp(1:3)*bet(1:3).';
eta = getCNorm(@(t)integY(abs(H - H3), x, y, t), 0, 1);
BTil = (1 + BTil) * eta;
fprintf("%20s%10f\n", 'Оценка погрешности', BTil / (1 - BTil) * getCNorm(@(t)double(subs(u3, x, t)), 0, 1));

eps = 1e-6;

fredgQuadCalc(H, f, x, y, eps);