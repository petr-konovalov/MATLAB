function Gauss()
    clc;
    format long;
    [size, matr] = getSystem('inp.txt');
    disp('�������: ');
    disp(matr);
    disp('����� ������������� �������: ');
    [res, matrSimple] = solveSimple(matr);
    disp('�������: ');
    disp(matrSimple);
    disp('�������: ');
    disp(res);
    printDiscrepancy(size, matr, res);
    disp('����� � ������� �������� ��������: ');
    [res, matrChoice] = solveChoice(matr);
    disp('�������: ');
    disp(matrChoice);
    disp('�������: ');
    disp(res);
    printDiscrepancy(size, matr, res);
    disp('�������� �������: ');
    backMatr = getBackMatr(size, matr);
    disp(backMatr);
    disp('�������� �������� �������: ');
    disp(backMatr * matr(1: size, 1: size));
    
    disp('���������� ����� ������: ');
    disp(matr(1: size, 1: size) \ matr(1: size, size + 1: size + 1));
end

function printDiscrepancy(size, matr, res)
    disp('�������: ');
    disp(matr(1: size, size + 1: size + 1) - matr(1: size, 1: size) * res);
end