function Yakoby()
    clc;
    format long;
    eps = 1e-5;
    
    [~, A] = getMatr('inpMatr.txt');
    disp('Исходная матрица:');
    disp(A);
     
    [L, X] = yakobyMethod(A, eps);
    disp('Результат:');
    disp(L);
    disp('Невязка:');
    disp(A * X - L * X);
end