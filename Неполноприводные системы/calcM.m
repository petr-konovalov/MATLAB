function res = calcM(q)
    global A B R l; 
    res = [A, B*cos(q(2)); R*cos(q(2)), l];
end