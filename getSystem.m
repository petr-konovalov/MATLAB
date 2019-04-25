function [size, matr] = getSystem(fileName)
    f = fopen(fileName,'r');
    size = fscanf(f, '%d', [1]);
    matr = fscanf(f, '%f', [size + 1, size])';
    fclose(f);
end

