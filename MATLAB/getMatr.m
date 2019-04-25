function [size, matr] = getMatr(fileName)
    f = fopen(fileName,'r');
    size = fscanf(f, '%d', [1]);
    matr = fscanf(f, '%f', [size, size])';
    fclose(f);
end
