function X = difTStepToFixTStep(step, gt, gX)
    n = floor((gt(size(gt, 1))-gt(1))/step);
    X = zeros(n+1, 2);
    for k = 0: n
        X(k+1,:) = difTStepGridFunc(gt(1)+k*step, gt, gX);
    end
end