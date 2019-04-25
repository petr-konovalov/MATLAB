function Yakoby()
    clc;
    format long;
    eps = 1e-5;
    
    [~, A] = getMatr('inpMatr.txt');
    disp('�������� �������:');
    disp(A);
     
    [L, X] = yakobyMethod(A, eps);
    disp('���������:');
    disp(L);
    disp('�������:');
    disp(A * X - L * X);
end