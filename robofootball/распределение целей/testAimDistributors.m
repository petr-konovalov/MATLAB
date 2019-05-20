testCount = 1000;
pntCnt = 4;
for test = 1: testCount
    startPos = zeros(pntCnt, 2);
    aimPos = zeros(pntCnt, 2);
    l = -50;
    r = 50;
    u = 50;
    d = -50;

    for k = 1: pntCnt
        startPos(k, 1) = rand(1) * (r - l) + l;
        startPos(k, 2) = rand(1) * (u - d) + d;
        aimPos(k, 1) = rand(1) * (r - l) + l;
        aimPos(k, 2) = rand(1) * (u - d) + d;
    end
    BFAD = minMaxEdgeBFAD(startPos, aimPos);
    MAD = matchingAD(startPos, aimPos);
    if isequal(BFAD.getDistribution, MAD.getDistribution)
        fprintf('Test %5d ok\n', test);
    else
        fprintf('Test %5d fail\n', test);
    end
end


