function val = fixTStepGridFunc(t, step, gX)
    n = floor(t/step);
    lt = n*step;
    n = n+1;
    val = gX(n, :)+(t-lt)*(gX(n+1,:)-gX(n, :))/step;
end