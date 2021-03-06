function dX = calcV(X)
    r1 = X(1:3);
    r2 = X(4:6);
    r3 = X(7:9);
    n = getNorm(r1, r2, r3);
    v1 = calcU(calcField(r1));
    v2 = calcU(calcField(r2));
    v3 = calcU(calcField(r3));
%     v_1 = (2*v1-v2-v3)/3;
%     v_2 = (2*v2-v1-v3)/3;
%     v_3 = (2*v3-v1-v2)/3;
    dX = zeros(9, 1);
%     dX(1:3) = n*v_1;
%     dX(4:6) = n*v_2;
%     dX(7:9) = n*v_3;
    dX(1:3) = n*v1;
    dX(4:6) = n*v2;
    dX(7:9) = n*v3;
end