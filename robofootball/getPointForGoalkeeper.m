%[x,y] = getPointForGoalkeeper(A,B,C,V)
v = [A(1) - B(1), A(2) - B(2)];
u = [-V(2), V(1)];
t = psevdoScalMultiplication(C-A, u)/ psevdoScalMultiplication(v,u);
x = A(1) + t * v(1);
y = A(2) + t * v(2);

disp(x);
disp(y);


function t = psevdoScalMultiplication(A, B)
    t = A(1)*B(2) - A(2)*B(1);
end