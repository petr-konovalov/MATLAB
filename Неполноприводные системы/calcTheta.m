function res = calcTheta(t)
    global w0 R L stp FStepX T version;
    switch (version)
        case 0
            res = -asin(R*w0/L*sin(t));
        case 1
            n = floor(t/T);
            res = fixTStepGridFunc(t-n*T, stp, FStepX(:, 1));
    end
end