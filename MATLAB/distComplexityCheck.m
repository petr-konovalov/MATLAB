fileName = 'table2.txt';
fileSize = 1400;

file = fopen(fileName, 'r');
firstSum = 0;
secondSum = 0;

for k = 1: fileSize
    inp = fscanf(file, '%i', [8]);
    firstSum = firstSum + inp(4) / inp(7);
    secondSum = secondSum + inp(5) / inp(8);
end

fprintf('%f\n', firstSum / fileSize);
fprintf('%f\n', secondSum / fileSize);

fclose(file);