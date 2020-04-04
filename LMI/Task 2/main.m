%Простой пример
%A = [1 0 4; 0 2 0; 4 0 3];
%B = [3; 2; 1];
%C = [1 0 1; 0 1 0];

[A, B, C] = getRandGoodSystem(7, 3, 5);
disp('Матрицы исходной системы: ');
disp('A = ');
disp(A);
disp('B = ');
disp(B);
disp('C = ');
disp(C);

if checkSystem(A, B, C)
    [K, L] = solve(A, B, C);

    disp('Матрица K:');
    disp(K);
    disp('Матрица L:');
    disp(L);

    closedMtx = [A, B*K; -L*C, A+B*K+L*C];
    disp('Матрица замкнутой системы:');
    disp(closedMtx);

    disp('Собственные числа матрицы замкнутой системы:');
    eigV = eig(closedMtx);
    disp(eigV);

    if isempty(find(real(eigV) >= 0, 1))
        disp('Вывод: матрица замкнутой системы устойчива');
    else
        disp('Вывод: что-то пошло не так')
    end
end