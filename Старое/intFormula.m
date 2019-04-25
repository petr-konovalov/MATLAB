function intFormula
    A = [1.0969590648 0.5298028196];
    x = [0.0524684657 0.3678213894];
    fprintf('%12.8f\n', A*f(x)');
    x = [0.0150670778 0.1351507947 0.3153559011 0.460600723];
    A = getA(x(2), x(3), x(4))/del(x(1), x(2), x(3), x(4));
    A = [A getA(x(1), x(3), x(4))/del(x(2), x(1), x(3), x(4))];
    A = [A getA(x(1), x(2), x(4))/del(x(3), x(1), x(2), x(4))];
    A = [A getA(x(1), x(2), x(3))/del(x(4), x(1), x(2), x(3))];
    fprintf('%12.8f\n', A*f(x)');
end
    
function [res] = f(x)
    res = cos(x);
end

function [res] = getA(x1, x2, x3)
    res = 1/(2^3.45*3.45)-(x1+x2+x3)/(2^2.45*2.45)+(x1*x2+x1*x3+x2*x3)/(2^1.45*1.45)-x1*x2*x3/(2^0.45*0.45);
end

function [res] = del(x1, x2, x3, x4)
    res = (x1 - x2) * (x1 - x3) * (x1 - x4);
end
    

        