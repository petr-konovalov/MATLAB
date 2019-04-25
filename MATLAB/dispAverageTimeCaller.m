fileName = 'table3.txt';
fileSize = 1400;

lfc = 0;
rgc = 400;
stepc = 200;
lfd = 0;
rgd = 60;
stepg = 20;

for bnd = lfc: stepc: rgc
    for dst = lfd: stepg: rgd
        fprintf('Curvature bound: [%i; %i]\n', bnd, bnd + stepc);
        fprintf('Dist bound: [%i; %i]\n', dst, dst + stepg);
        dispAverageTime(fileName, fileSize, [bnd, bnd + stepc], [dst, dst + stepg]);
        fprintf('\n');
    end
end
