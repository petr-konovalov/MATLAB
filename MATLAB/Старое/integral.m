function integral
    a = 0;
    b = 0.5;
    I = -4/7 + 10/7*log(exp(0.4) - 0.7) - 10/7*log(0.3);
    A1 = (b - a) ^ 3 / (24 * 64) * 1700 / 27;
    A2 = 2 * A1;
    A3 = (b - a) ^ 5 / (2880 * 64 * 64) * 5939.51;
    fprintf('Точное значение: %.8f\n', I);
    fprintf('%12s %12s %12s %12s %12s\n', 'I8  ', 'I16  ', 'IR  ', '|I - I8| ', 'A  ');
    I8 = fm1(a, b, 8); I16 = fm1(a, b, 16); IR = runge(I8, I16, 4);
    fprintf('%12.8f %12.8f %12.8f %12.8f %12.8f\n', I8, I16, IR, abs(I8 - I), A1);
    I8 = fm2(a, b, 8); I16 = fm2(a, b, 16); IR = runge(I8, I16, 4);
    fprintf('%12.8f %12.8f %12.8f %12.8f %12.8f\n', I8, I16, IR, abs(I8 - I), A2);
    I8 = fm3(a, b, 8); I16 = fm3(a, b, 16); IR = runge(I8, I16, 16);
    fprintf('%12.8f %12.8f %12.8f %12.8f %12.8f\n', I8, I16, IR, abs(I8 - I), A3);
%{%}

function [res] = f(x)
    %{res = 1 / (exp(x) - 0.7);}%
    res = x^(-0.55)*(x-0.36782138935536042)/(0.0524684657171-0.36782138935536042);
%{%}

function [res] = sf(a, n, h)
    res = f(a);
    for k = 1: n - 1
        res = res + f(a + k * h);
    end
%{%}

function [res] = fm1(a, b, n)
    h = (b - a) / n;
    res = sf(a + h / 2, n, h) * h;
%{%}

function [res] = fm2(a, b, n)
    h = (b - a) / n;
    res = h * ((f(a) + f(b)) / 2 + sf(a + h, n - 1, h));
%{%}

function [res] = fm3(a, b, n)
    h = (b - a) / n;
    res = h / 6 * (f(a) + f(b) + 2 * sf(a + h, n - 1, h) + 4 * sf(a + h / 2, n, h));
%{%}

function [res] = runge(In, I2n, mult)
    res = (In - I2n * mult) / (1 - mult);
%{%}