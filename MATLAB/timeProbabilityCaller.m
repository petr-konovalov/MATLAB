fileName = 'table1.txt';
fileSize = 5000;

for windowSize = [2000, 1000, 500]
    for l = 0: windowSize: 4000
        timeProbabilityFunction(fileName, fileSize, l, l + windowSize);
    end
end