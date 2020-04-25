function res = calcDTheta(t)
    global w0 R L stp FStepX T version;
    switch (version)
        case 0
            res = -cos(t)/sqrt((L/(w0*R))^2-sin(t)^2);
        case 1
            n = floor(t/T);
            res = fixTStepGridFunc(t-n*T, stp, FStepX(:, 2));
    end
end