syms x;

size = 10;

funcs = sym(zeros(1, size));

for i = 1: size
    funcs(i) = getCoordFunc(i, x);
end

preCalcMatr = zeros(size, size);
for i = 1: size
    for j = 1: size
        preCalcMatr(i, j) = funcMult(funcs(j), funcs(i), x, @difEqOp);
    end
end