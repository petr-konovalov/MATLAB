function Gauss()
    clc;
    format long;
    [size, matr] = getSystem('inp.txt');
    disp('Система: ');
    disp(matr);
    disp('Схема единственного деления: ');
    [res, matrSimple] = solveSimple(matr);
    disp('Матрица: ');
    disp(matrSimple);
    disp('Решение: ');
    disp(res);
    printDiscrepancy(size, matr, res);
    disp('Схема с выбором главного элемента: ');
    [res, matrChoice] = solveChoice(matr);
    disp('Матрица: ');
    disp(matrChoice);
    disp('Решение: ');
    disp(res);
    printDiscrepancy(size, matr, res);
    disp('Обратная матрица: ');
    backMatr = getBackMatr(size, matr);
    disp(backMatr);
    disp('Проверка обратной матрицы: ');
    disp(backMatr * matr(1: size, 1: size));
    
    disp('Встроенный метод Гаусса: ');
    disp(matr(1: size, 1: size) \ matr(1: size, size + 1: size + 1));
end

function printDiscrepancy(size, matr, res)
    disp('Невязка: ');
    disp(matr(1: size, size + 1: size + 1) - matr(1: size, 1: size) * res);
end